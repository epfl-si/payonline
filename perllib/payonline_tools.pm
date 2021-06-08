#!/usr/bin/perl
#
##############################################################################
#
# Service Name: payonline
# File Name:    payonline_tools.pl
# Author:       Ion CIONCA (Ion.Cionca@epfl.ch) - 2004-2019
#
#########################################################################
#####
#
#

package payonline_tools;

use Net::LDAP;
use Mail::Sendmail;
use Digest::MD5 qw(md5_hex);
use Digest::SHA1 ;
use MIME::Base64 ;
use Net::CIDR;
use Net::CIDR ':all';
use JSON;

use Cadi::Accreds;
use Encode;

use CGI qw/ :cgi-lib -utf8 /;

use strict;
use vars qw( $absdbh $DEBUG $logfile $errmsg $demfond $codeTVA
            $tmpldir
            $ges_list $HMAC_salts $PayonlineShopID $Rights $rejectIP
           $epflLOGO $mailFrom $mailBcc $exceptions $CAMIPROload);

use base 'Exporter'; our @EXPORT = our @EXPORT_OK = qw(log_event);

require '/opt/dinfo/etc/params';

my $me 		= $ENV {SCRIPT_NAME};
my $us 		= $ENV {SERVER_NAME};
my $qs 		= $ENV {QUERY_STRING};
my $pi 		= $ENV {PATH_INFO};
my @days 	= (0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
my $resp 	= 'payonline-ops@groupes.epfl.ch';
my %HashID	= (
   	'CHF', 	qq{2543},
   	'USD',	qq{3406},
   	'EUR',	qq{3405},
	);

#	- maintenance files : $MAINT_DIR/maint_<startdate><enddate>
my $MAINT_DIR = '/var/www/vhosts/payonline.epfl.ch/private/maintenaces';

$rejectIP = ('128.178.109.243','157.55.39.166');	#	crawlers 

$epflLOGO	= 'https://web2018.epfl.ch/2.0.0/icons/epfl-logo.svg';
$demfond 	= 'bertold.walther@epfl.ch,payonline-ops@groupes.epfl.ch';
$codeTVA	= 'Q7';
$mailFrom	= 'noreply@epfl.ch';

#	- SPECIAL EXTRACTION FOR CAMIPRO
$CAMIPROload='e4shukt1c7d7z5qx1vbdngtlymvhlm5z';

$exceptions = {
	'ybvoa633uvw3b56hxhxr665yiqwyboni' => {
		descr		 => qq{Donation 50fifty},
		mailFrom => 'nathalie.fontana@epfl.ch',
		alertOn	 => 1000,
		alertTo	 => 'campaign@epfl.ch',
	}
};

my $alertTo = 'campaign@epfl.ch';
my $alertTo = 'payonline-ops@groupes.epfl.ch';

$exceptions = {
	'g0svljq62cqs64t1lnje0pt266gm82e6' => {
		descr		 => qq{Donation 50fifty},
		mailFrom => 'nathalie.fontana@epfl.ch',
		alertOn	 => 1000,
		alertTo	 => $alertTo,
	},
	'tozdj8xsuugfrmmpzyy6e0kqblg2opkq' => {
		descr		 => qq{Donation 50fifty},
		mailFrom => 'nathalie.fontana@epfl.ch',
		alertOn	 => 1000,
		alertTo	 => $alertTo,
	},	
	'c7n4htdrnzjtwyotb6di2rhwre3u5gu8' => {
		descr		 => qq{Donation 50fifty},
		mailFrom => 'nathalie.fontana@epfl.ch',
		alertOn	 => 1000,
		alertTo	 => $alertTo,
	}
};


=item log_event ($event_name, $k1 => $v1, ...)

Log arguments as a JSON associative array to stderr, for Kibana to digest.

=cut

sub log_event {
  my (%details) = ("event", @_);
  print STDERR JSON::encode_json(\%details) . "\n";
}

#--------
sub init {

	if ($rejectIP =~ /$ENV{REMOTE_ADDR}/) {
          log_event "IP rejected", ip => $ENV{REMOTE_ADDR};
          exit;
	}

	$DEBUG  = 0;
	$absdbh = new Cadi::CadiDB (
	  dbname => 'payonline',
          utf8 => 1
	);
	die "FATAL payonline DB ACCESS" unless $absdbh;
	
	my $accredconf = $DEBUG ? {
	  accreddbname => 'accred',
	   dinfodbname => 'dinfo',
	} : {
	  accreddbname => 'accred',
	   dinfodbname => 'dinfo',
	};
}

#--------
sub uniq {
  my (@myarr) = @_;
  my %count;
  @myarr = grep { ++$count{$_} < 2} @myarr;
  return @myarr;
}
#--------
sub getcrtdate {
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
    $mon++;
    $year += 1900;
    $days[2] = 29 if (($year % 400 == 0) || ($year % 4 == 0 && $year % 100 != 0)) ;
    return sprintf "%4d-%02d-%02d %02d:%02d",$year,$mon,$mday,$hour,$min;
}
#--------
sub datevalide {
  my ($date) = @_;
	return '' unless $date;

  my ($aa, $mm, $jj) = split(/\-/,$date);
  return '' unless $aa > 2000;
  $mm =~ s/^0//;
  return '' if ($mm < 1) or ($mm > 12);
  return '' if $jj > $days[$mm] or $jj < 0;
   my $retdate = sprintf "%4d-%02d-%02d 00:00",$aa,$mm,$jj;
   return $retdate;
}
#--------
sub prdate {
    my ($date, $flag) = @_;
    
    return '' unless $date and ($date ne '0000-00-00');
    my ($datepart,$hourpart) = split(/\s/, $date);
    my $yy = substr ($date,0,4);
    my $mm = substr ($date,5,2);
    my $dd = substr ($date,8,2);
    my $revdate = sprintf "%02d.%02d.%04d", $dd,$mm,$yy;

    if ($flag eq 'date') {
      return ($revdate);
    } else {
      return ("$revdate $hourpart");
    }
}

#--------
sub send_mail {
  my ($dest, $subj, $msg) = @_;

  my $log_event = "payonline::send_mail";
  log_event $log_event, to => $dest, subject => $subj;
  $dest			 ='payonline-ops@groupes.epfl.ch' if $DEBUG;

  my %mail;
  $mail{From} 	 = 'noreply@epfl.ch'; 
  $mail{Bcc}  	 = $resp;
  $mail{To}   	 = $dest;

  $mail{Smtp} 	 = 'mail.epfl.ch';
  $mail{Subject} = $subj;
  $mail{Message} = $msg;
  if (sendmail (%mail)) {
     if ($Mail::Sendmail::error) {
       log_event($log_event, error => $Mail::Sendmail::error);
     } else {
       $msg =~ s/\n/;/g;
       log_event($log_event, status => "OK");
     }
  } else {
    log_event($log_event, status => "failed", error => $Mail::Sendmail::error);
  }
}
#--------
sub send_mail_bc {
  my ($dest, $bcc, $subj, $msg) = @_;

  my $log_event = "payonline::send_mail_bc";

	$mailBcc .= ",$bcc" if $bcc;
	$mailBcc	=~ s/^,//;
	$mailBcc	=~ s/,$//;
  log_event $log_event, dest => $dest, mailFrom => $mailFrom,
    mailBcc =>$mailBcc, subject => $subj;

  return unless $dest or $mailBcc;
  
  $dest = 'payonline-ops@groupes.epfl.ch' if $DEBUG;

  my %mail;
  $mail{From} = $mailFrom; 
  $mail{Bcc}  = $mailBcc if $mailBcc;
  $mail{To}   = $dest;

  $mail{Smtp} 	 = 'mail.epfl.ch';
  $mail{Subject} = $subj;
  $mail{Message} = $msg;	
  if (sendmail (%mail)) {
     if ($Mail::Sendmail::error) {
       log_event($log_event, error => $Mail::Sendmail::error);
     } else {
       $msg =~ s/\n/;/g;
       log_event($log_event, status => "OK");
     }
  } else {
    log_event($log_event, status => "failed", error => $Mail::Sendmail::error);
  }
}
#--------
sub get_time {
  my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
  $mon++;
  $year += 1900;
  $days[2] = 29 if (($year % 400 == 0) || ($year % 4 == 0 && $year % 100 != 0)) ;

  log_event "get_time", last_feb_day => $days[2];

  return sprintf "%4d-%02d-%02d %02d:%02d:00",$year,$mon,$mday,$hour,$min;
}
#--------
sub gentablekey {
  my ($table, $size) = @_;

 while (1) {
    srand (time ^ ($$ + ($$ << 15)));
    my $key = "";
    for (my $i = 0; $i < $size; $i++) {
      my $car .= int rand (35);
      $key .= ('a'..'z', '0'..'9')[$car];
    }
    my $sql = qq{select id from $table where id=?};
    my $sth = dbquery ($sql, ($key));
    unless (my ($id) = $sth->fetchrow_array ()) {
      my $sql = qq{insert into $table set id=?};
      log_event "payonline::gentablekey", key => $key;
      my $sth = dbquery ($sql, ($key));
      return $key if $sth;
    }
 }
}
#--------
sub setLog {
  $logfile = shift;
}
#--------
sub setTmplDir {
  $tmpldir = shift;
}
#---------
sub debug_ENV {
  foreach my $item (sort keys %ENV) {
   print STDERR qq{$item=$ENV{$item}
   };
  }
  print STDERR qq{================================
  };
}
#---------
sub debug_params {
  my ($params) = @_;

  log_event "debug_params", %$params;
}
#--------
sub genkey {
 srand (time ^ ($$ + ($$ << 15)));
 my $key = "";
 for (my $i = 0; $i < 32; $i++) {
   my $car .= int rand (35);
   $key .= ('a'..'z', '0'..'9')[$car];
 }
 return $key;
}
#--------
sub loadargs {
  return Vars;
}
#=============
sub dbconnect {
	my ($dbkey) = @_;

	my $dbconf_file = '/opt/dinfo/etc/dbs.conf';
	die "dbconnect : ERR OPEN $dbconf_file [$!]" unless (open (DBCONF, "$dbconf_file")) ;
	my ($dbname, $dbhost, $dbuser, $dbpwd) ;
	while (<DBCONF>) {
		chomp;
		next if $_ =~ /^#/;	# - comments
		$_ =~ s/\t+/\t/g;
		next unless $_;
		my @items = split /\t/, $_;

		next unless $items[0] eq $dbkey;
		$dbname = $items[1];
		$dbhost = $items[2];
		$dbuser = $items[3];
		$dbpwd  = $items[4];
		last;
	}
	close DBCONF;

	die "dbconnect : ERR DB CONFIG : $dbname, $dbhost, $dbuser" unless ($dbname and $dbhost and $dbuser and $dbpwd) ;
	my $dsndb    = qq{dbi:mysql:$dbname:$dbhost:3306}; 

        log_event "dbconnect", db => $dsndb;

	my $dbh = DBI->connect ($dsndb, $dbuser, $dbpwd, {mysql_enable_utf8 => 1});

	die "dbconnect : ERR DBI CONNECT : $dbhost, $dbname, $dbuser" unless $dbh;
	
	return $dbh;
}

#___________
sub dbquery {
  my ($sql, @params) = @_;

  my $sth = $absdbh->prepare( $sql) or die "database fatal erreur prepare\n$DBI::errstr\n$sql\n";
  $sth->execute (@params) or die "database fatal erreur : execute : $DBI::errstr\n$sql\n@params\n";

  return $sth;
}

#--------
sub write_log_db {
  my ($user, $descr) = @_;
  
  dbquery ("insert into logs set ts=now(),	sciper=?,	ip='$ENV{REMOTE_ADDR}',	descr=?", ($user->sciper, $descr));
}


#--------
sub getTrans {
  my ($id_trans, $etat) = @_;
  return unless $id_trans;
  return if  $id_trans =~ /select/i;
  return if  $id_trans =~ /insert/i;
  return if  $id_trans =~ /update/i;
  return if  $etat     =~ /select/i;
  return if  $etat     =~ /insert/i;
  return if  $etat     =~ /update/i;

  my $sql = qq{select * from transact where id=?};
  my @params = ($id_trans);
  if ($etat) {
  	$sql .= qq{ and etat=?} ;
  	push @params, $etat;
  }
  my $sth = dbquery ($sql, @params) or return;
  return $sth->fetchrow_hashref ();
  
}
#--------
sub getQuery {
  my ($id_trans) = @_;
#  log_event "payonline::getQuery", id_trans => $id_trans;
  return unless $id_trans;
  return if  $id_trans =~ /select/i;
  return if  $id_trans =~ /insert/i;
  return if  $id_trans =~ /update/i;

  my $sql = qq{select query from transact where id=?};
  my $sth = dbquery ($sql, ($id_trans)) or return;
  my ($res) = $sth->fetchrow_array ();
  return unless $res;
  my %query;
  foreach my $item (split(/&/, $res) ) {
    my ($param, $val) = split (/=/, $item);
    $val =~ s/%26/&/g;
    $query{$param} = $val;
  }
# log_event "payonline::getQuery::params", %query;
  return \%query;
}

#------
sub getTVAcode {
	my ($compteb) = @_;

	return 'Q0' if $compteb =~ /(740050|740060|710100|710120|710130|710140|746020|747040|786030)/;
#	- start on 2018
	return 'C9' if $compteb =~ /(700010|700020|783120)/;
	return 'C5' if $compteb eq '700060';
	return 'C7';

#	- remove
	return 'A9' if $compteb =~ /(700010|700020|783120)/;
	return 'A5' if $compteb =~ /700060/;
	return 'Q7';
#	- 

}

#--------
sub getArgs {
  my ($query) = @_;

  return unless $query;
  my %query;
  foreach my $item (split(/&/, $query) ) {
    my ($param, $val) = split (/=/, $item);
    $val =~ s/%26/&/g;
    $query{$param} = $val;
  }
  return \%query;
}

sub ip2dec ($) {
    unpack N => pack CCCC => split /\./ => shift;
}

sub is_ip_in_postfinance_ranges {
  my @YP_IP_range = (
    '185.8.52.0/22',
    '212.23.45.96/28',
    '213.254.248.96/27',
    '212.35.124.160/27',
    '84.233.249.96/27',
    '62.72.112.128/28',
    '84.199.92.128/26',
    '91.208.214.0/24',
    '185.8.52.0/22',
    '185.139.244.0/22',
   );

	my ($addr) = @_;
	return 0 unless $addr;
	my $dec_addr = ip2dec($addr);
	foreach my $ip (@YP_IP_range) {
		my ($start_range, $end_range) = split /-/, join '',Net::CIDR::cidr2range($ip);
		my $start_addr = ip2dec($start_range);
		my $end_addr   = ip2dec($end_range);
		return 1 if ($dec_addr ge $start_addr) && ($dec_addr le $end_addr);
	}
	return 0;
}

sub is_known_postfinance_ip {
  my ($ip) = @_;

  return grep { $_ eq $ip } qw(
	185.8.52.254 185.8.53.254 185.8.54.254

	194.41.152.138 194.41.152.139 194.41.216.138 194.41.216.139

	212.23.45.96 212.23.45.97 212.23.45.98 212.23.45.99
	212.23.45.100 212.23.45.101 212.23.45.102 212.23.45.103
	212.23.45.104 212.23.45.105 212.23.45.106 212.23.45.107
	212.23.45.108 212.23.45.109 212.23.45.110 212.23.45.111

	212.35.124.160 212.35.124.161 212.35.124.162 212.35.124.163
	212.35.124.164 212.35.124.165 212.35.124.166 212.35.124.167
	212.35.124.168 212.35.124.169 212.35.124.170 212.35.124.171
	212.35.124.172 212.35.124.173 212.35.124.174 212.35.124.175

	213.254.248.96 213.254.248.97 213.254.248.98 213.254.248.99
	213.254.248.100 213.254.248.101 213.254.248.102
	213.254.248.103 213.254.248.104 213.254.248.105
	213.254.248.106 213.254.248.107 213.254.248.108
	213.254.248.109 213.254.248.110 213.254.248.111
                             );
}

#-------------
sub makeToken {
  my ($id_transact, $trans) = @_;
  return unless $trans && $id_transact;

	#	- new sha
  my $salt = join '', ('a'..'z')[rand 26,rand 26,rand 26,rand 26,rand 26,rand 26,rand 26,rand 26];
  my $ctx = Digest::SHA1->new;
  my $str = "$id_transact:$trans->{id_inst}";

  $ctx->add($str);
  $ctx->add($salt);
  my $token = '{SSHA}'.MIME::Base64::encode($ctx->digest . $salt,'');
# log_event "makeToken", str => $str, token => $token;
  return qq{$salt:$token};
}

#-------------
sub inMaintenance {
	#	- POSTFINANCE MAINTENANCE
	my $crtdate = shift;

	opendir DIR, "$MAINT_DIR" ||
          log_event "inMaintenance", directory => $MAINT_DIR, error => $!;
	my @maintenances = readdir (DIR);
	close DIR;

	foreach my $date (@maintenances) {
		next unless $date;
		next if $date =~ /^\./;
		my $startdate = substr ($date, 0, 16);
		my $enddate   = substr ($date, 16, 16);
		next if $crtdate lt $startdate || $crtdate gt $enddate;
                log_event "inMaintenance", crtdate => $crtdate, startdate => $startdate, enddate => $enddate;
		return qq{$startdate,$enddate};
	}
        log_event "inMaintenance", state => "NO maintenance";
	return 0;
}

package YellowPayFlow;  #########################################

sub _makeHash {
  my ($data, $hmac_key) = @_;

  $data->{currency} ||= "CHF";

  my $ctx = Digest::SHA1->new;
  my $txt;
  if (exists $data->{PSPID}) {
    # "in" hash formula
    $txt = $data->{orderID}.$data->{amount}.$data->{currency}.$data->{PSPID}
  } elsif (exists $data->{PAYID}) {
    # "out" hash formula
    $txt = $data->{orderID}.$data->{currency}.$data->{amount}.$data->{PM}.$data->{ACCEPTANCE}.$data->{STATUS}.$data->{CARDNO}.$data->{PAYID}.$data->{NCERROR}.$data->{BRAND}
  }
  $txt .= $hmac_key;
  $ctx->add($txt);
  my $hexdigest = uc($ctx->hexdigest);
#  payonline::log_event "makeHash", txt => $txt, digest => $hexdigest;
  return ($hexdigest);
}


sub _postfinance_srv {
  my ($test_or_prod) = @_;
  return "https://e-payment.postfinance.ch/ncol/$test_or_prod/orderstandard.asp";
};

sub get_server_url { shift->{srv} }
sub get_shop_id { shift->{shopID} }

package YellowPayFlow::Payonline;

use base qw(YellowPayFlow);

sub test {
  bless {
    shopID => $payonline_tools::PayonlineShopID,
    hmac   => $payonline_tools::HMAC_salts->{epfl}->{test},
    srv => YellowPayFlow::_postfinance_srv("test"),
  }, shift
}

sub prod {
  bless {
    shopID => $payonline_tools::PayonlineShopID,
    hmac   => $payonline_tools::HMAC_salts->{epfl}->{prod},
    srv => YellowPayFlow::_postfinance_srv("prod"),
  }, shift
}

sub by_instance {
  my ($class, $instance) = @_;
  $instance->{etat} eq 'test' ? $class->test : $class->prod;
}

sub makeHash {
  my ($self, $struct) = @_;
  return YellowPayFlow::_makeHash($struct, $self->{hmac});
}

package Payonline::User;  #######################################

use Encode;
use Cadi::CadiDB;

sub from_tequila_attrs {
  my ($class, $tequila_attrs) = @_;
  return bless {
    sciper => $tequila_attrs->{uniqueid},
    nom    => _tequila_to_unicode($tequila_attrs->{name}),
    prenom => _tequila_to_unicode($tequila_attrs->{firstname}),
    email  => $tequila_attrs->{email},

   }, $class;
}

sub by_sciper {
  my ($class, $sciper) = @_;

  return bless { sciper => $sciper }, $class;
}

sub nom {
  my ($self) = @_;
  $self->_fetch_nom_prenom;
  return $self->{nom};
}

sub prenom {
  my ($self) = @_;
  $self->_fetch_nom_prenom;
  return $self->{prenom};
}

sub email {
  my ($self) = @_;
  $self->_fetch_email;
  return $self->{email};
}

sub sciper { shift->{sciper} }

sub mail { shift->email }

sub _fetch_nom_prenom {
  my ($self) = @_;
  return if ($self->{nom} || $self->{prenom});

  my $sql = qq{select distinct sciper.nom_acc,sciper.prenom_acc from sciper where sciper.sciper=?};
  my $sth = _db_dinfo()->query ( $sql, ($self->{sciper})) or die "Unknown sciper in dinfo.sciper: $self->{sciper}";

  ($self->{nom}, $self->{prenom}) = $sth->fetchrow_array();
}

sub _fetch_email {
  my ($self) = @_;
  return if $self->{email};

  my $sql = qq{select distinct emails.addrlog from emails where emails.sciper=?};
  my $sth = _db_dinfo()->query ($sql, ($self->{sciper})) or die "Unknown sciper in dinfo.emails: $self->{sciper}";

  ($self->{email}) = $sth->fetchrow;
}

sub is_super_user {
  my ($self) = @_;

  my @su_list = qw(104782 149509 105640 146727 159357 148402 114746 181537 107490 254724 229454 268229);   # - ic, pschw, cl, mschl, bg-m, mf, bw, pf, nr

  return !! grep { $_ == $self->{sciper} } @su_list;
}

sub _tequila_to_unicode {
  my ($bytes) = @_;
  if (utf8::is_utf8($bytes)) {
    return $bytes;
  } else {
    return Encode::decode('UTF-8', $bytes, Encode::FB_CROAK);
  }
}

sub cfs {
  my ($self) = @_;
  my $unitlist = join ",", map { qq('$_') } $self->units_with_payonline_right;

  my @cfs;
  my $sql = qq{select cf,sigle from dinfo.unites where id_unite in ($unitlist)};
  my $sth = _db_dinfo()->query ( $sql);
  while (my ($cf,$sigle) = $sth->fetchrow_array ()) {
    next unless $cf;
    push (@cfs, "$sigle:$cf");
  }
  return (sort @cfs);
}

sub fonds {
  my ($self) = @_;
  my $unitlist = join ",", map { qq('$_') } $self->units_with_payonline_right;

  my $fondsperCF;
  my $sql = qq{select cf from dinfo.unites where id_unite in ($unitlist)};
  my $sth = _db_dinfo()->query ( $sql);
  while (my ($cf) = $sth->fetchrow_array ()) {
    my @fonds;
    $sql = qq{select no_fond,libelle from dinfo.fonds where cf = ? and etat='O'};
    my $sth = _db_dinfo()->query ( $sql, ("F$cf"));
    while (my ($no_fond,$libelle) = $sth->fetchrow_array ()) {
      push (@fonds, "$no_fond:$libelle");
    }
    $fondsperCF->{$cf} = \@fonds;
  }
  return $fondsperCF;
}

sub units_with_payonline_right {
  my ($self) = @_;

  if (! $self->{_units_with_payonline_right}) {
    my $payonline_right_id = 38;
    $self->{_units_with_payonline_right} = [keys %{ _accreds()->getAllUnitsWhereHasRight(
      $self->{sciper}, $payonline_right_id) }];
  }
  return @{$self->{_units_with_payonline_right}};
}

{
  my $db_dinfo;

  sub _db_dinfo {
    if (! $db_dinfo) {
      $db_dinfo = new Cadi::CadiDB (
        dbname => 'dinfo',
        trace => 1,
        utf8 => 1,
       );
    }
    return $db_dinfo;
  }

  my $accreds;
  sub _accreds {
    if (! $accreds) {
      $accreds = new Cadi::Accreds (caller => '104782', utf8 => 1);
    }
    return $accreds;
  }

}

1;
