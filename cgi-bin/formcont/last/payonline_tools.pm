#!/usr/bin/perl
#
##############################################################################
#
# File Name:    pay on line
# Author:       Ion CIONCA (Ion.Cionca@epfl.ch) - 2011
#
#########################################################################
#####
#
#

package payonline_tools;

use DBI;
use Net::LDAP;
use Crypt::RC4;
use Mail::Sendmail;
use Digest::MD5 qw(md5_hex);
use Digest::SHA1 ;

use strict;
use vars qw( $dbh $DEBUG $su_list $logfile $rc4key $errmsg $YellowPaySrv $demfond $codeTVA
            $YellowPayPrdSrv $YellowPayTstSrv $YellowPaySrv $YPServersIP $ShopID $tmpldir 
            $su_list $ges_list $SHAsalt $mode
            );

my $me 		= $ENV {SCRIPT_NAME};
my $us 		= $ENV {SERVER_NAME};
my $qs 		= $ENV {QUERY_STRING};
my $pi 		= $ENV {PATH_INFO};
my @days 	= (0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
my $resp 	= 'ion.cionca@epfl.ch';

# - change on postfinance
   $SHAsalt	= {
   	test => {
   		in  => './TzwrtGs*;6E=-tw!rE_nsg',
   		out	=> './TzwrtrE_nsgGs*;6E=-tw!',
   	},
   	prod => {
   		in  => './TzwrtGs*;6E=-tw!rE_nsg',
   		out	=> './TzwrtrE_nsgGs*;6E=-tw!',
   	},
   };

$YellowPayTstSrv= 'yellowpaytest.postfinance.ch';
$YellowPayPrdSrv= 'yellowpay.postfinance.ch';

$YPServersIP	= '194.41.152.138,194.41.152.139,194.41.216.138,194.41.216.139,212.23.45.96,212.23.45.97,212.23.45.98,212.23.45.99,212.23.45.100,212.23.45.101,212.23.45.102,212.23.45.103,212.23.45.104,212.23.45.105,212.23.45.106,212.23.45.107,212.23.45.108,212.23.45.109,212.23.45.110,212.23.45.111 ,213.254.248.96,213.254.248.97,213.254.248.98,213.254.248.99,213.254.248.100,213.254.248.101,213.254.248.102,213.254.248.103,213.254.248.104,213.254.248.105,213.254.248.106,213.254.248.107,213.254.248.108,213.254.248.109,213.254.248.110,213.254.248.111 ,212.35.124.160,212.35.124.161,212.35.124.162,212.35.124.163,212.35.124.164,212.35.124.165,212.35.124.166,212.35.124.167,212.35.124.168,212.35.124.169,212.35.124.170,212.35.124.171,212.35.124.172,212.35.124.173,212.35.124.174,212.35.124.175';


$su_list	= '104782';	# - ic,

#--------
sub utf8tolatin1 {
    my $string = shift;
    $string =~ s/([\xC0-\xDF])([\x80-\xBF])/chr(ord($1)<<6&0xC0|ord($2)&0x3F)/eg;
    return $string;
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

#-------------
sub makeHash {
  my ($data, $flag) = @_;

  my $ctx = Digest::SHA1->new;
  my $txt;
  if ($flag eq 'in') {
  	$txt = $data->{orderID}.$data->{amount}.'CHF'.$data->{PSPID};
  } else {
  	$txt = $data->{orderID}.'CHF'.$data->{amount}.$data->{PM}.$data->{ACCEPTANCE}.$data->{STATUS}.$data->{CARDNO}.$data->{PAYID}.$data->{NCERROR}.$data->{BRAND}
  }
  
  my $sha_salt = $SHAsalt->{$mode}->{$flag};
  $txt .= $sha_salt;
warn "formcont makeHash : txt=$txt, sha_salt=$sha_salt\n";
  $ctx->add($txt);
  my $hexdigest = uc($ctx->hexdigest);
warn "formcont makeHash : digest=$hexdigest\n";
  return ($hexdigest);
}

#--------
sub send_mail {
  my ($dest, $subj, $msg) = @_;

warn "formcont :: send_mail : $dest, $subj\n";
  $dest='ion.cionca@epfl.ch' if $DEBUG;
  my %mail;
  $mail{From} = 'noreply@epfl.ch'; 
  $mail{Bcc}  = 'formcont@epfl.ch';
  $mail{Bcc}  = 'comptafcue@unil.ch';
  $mail{To}   = $dest;

  $mail{Smtp} 	 = 'mail.epfl.ch';
  $mail{Subject} = $subj;
  $mail{Message} = $msg;	
  if (sendmail (%mail)) {
     if ($Mail::Sendmail::error) {
		warn "formcont :: send_mail : **ERROR** : $Mail::Sendmail::error\n";
     } else {
		$msg =~ s/\n/;/g;
		warn "formcont :: send_mail : $mail{To}, SUBJ: $subj\n";
     }
  } else {
		warn "formcont :: send_mail : **ERROR** : $Mail::Sendmail::error\n";
  }
}
#--------
sub get_time {
  my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
  $mon++;
  $year += 1900;
  $days[2] = 29 if ($year % 400 == 0) || ($year % 4 == 0 && $year % 100 != 0) ;
  return sprintf "%4d-%02d-%02d %02d:%02d:00",$year,$mon,$mday,$hour,$min;
}

#--------
sub gentablekey {
 my ($userdata) = @_;
  
 return unless $userdata;

 my $size = 18;
 while (1) {
#warn "payonline :: gentablekey ...";
    srand (time ^ ($$ + ($$ << 15)));
    my $key = "";
    for (my $i = 0; $i < $size; $i++) {
      my $car .= int rand (35);
      $key .= ('a'..'z', '0'..'9')[$car];
    }
    my $sql = qq{select id from transact where id='$key'};
    my $sth = dbquery ($sql);
    
    $userdata->{name} 		=~ s/'/''/g;
    $userdata->{firstname} 	=~ s/'/''/g;
    $userdata->{zip}		=~ s/'/''/g;
    $userdata->{addr}		=~ s/'/''/g;
    $userdata->{city} 		=~ s/'/''/g;
    $userdata->{email} 		=~ s/'/''/g;
    $userdata->{nopernum}	=~ s/'/''/g;
    $userdata->{nofacture}	=~ s/'/''/g;
    $userdata->{nocours}	=~ s/'/''/g;
    $userdata->{id_transact}=~ s/'/''/g;
    
    unless (my ($id) = $sth->fetchrow_array ()) {
      my $sql = qq{insert into transact set
      	id='$key',
      	name='$userdata->{name}',
      	firstname='$userdata->{firstname}',
      	addr='$userdata->{addr}',
      	zip='$userdata->{zip}',
      	city='$userdata->{city}',
      	country='$userdata->{country}',
      	nopernum='$userdata->{nopernum}',
      	nofacture='$userdata->{nofacture}',
      	nocours='$userdata->{nocours}',
      	amount='$userdata->{amount}',
      	raison='$userdata->{raison}',
      	email='$userdata->{email}',
      	id_transact='$userdata->{id_transact}'
      };
warn "formcont :: gentablekey : key=$key\n";
      my $sth = dbquery ($sql);
      return $key if $sth;
    }
 }
}

#--------
sub setYellowPaySrv {

  die "formcont :: payonline : ** FATAL : no mode" unless $mode;
  
  if ($mode eq 'test') {
	$YellowPaySrv = 'https://e-payment.postfinance.ch/ncol/test/orderstandard.asp';
  } else {
	$YellowPaySrv = 'https://e-payment.postfinance.ch/ncol/prod/orderstandard.asp'
  }

}
#--------
sub setDEBUG {
  $DEBUG = shift;
#  warn "payonline_tools :: DEBUG=$DEBUG";
}
#--------
sub setLog {
  $logfile = shift;
}
#--------
sub setRC4key {
  $rc4key = shift;
}
#--------
sub setTmplDir {
  $tmpldir = shift;
}
#---------
sub RC4decrypt {
  my ($txt, $flag) = @_;
  die "RC4decrypt: no rc4key" unless $rc4key;
  
  my $rc4 = Crypt::RC4->new ($rc4key);
  return $rc4->RC4 (pack ("h*", $txt));
}
#---------
sub RC4encrypt {
  my ($txt, $flag) = @_;
  die "RC4encrypt: no rc4key" unless $rc4key;
  my $rc4 = Crypt::RC4->new ($rc4key);

  return unpack ("h*", $rc4->RC4 ($txt)) unless $flag;

  my $RC4pwd = genkey ();
  my $rc4txt = unpack ("h*", $rc4->RC4 ($RC4pwd))."\n";
  $rc4       = Crypt::RC4->new ($RC4pwd);
  my $count  = 0;
  foreach my $item (split(/\n/, $txt)) {
   $rc4txt   .= unpack ("h*", $rc4->RC4 ($item))."\n";
   $count++;
  }
  $rc4txt   .= unpack ("h*", $rc4->RC4 ("count=$count"))."\n";
  return $rc4txt;
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
  
  foreach my $item (sort keys %$params) {
   warn "formcont : DEBUG::$item=$params->{$item}=\n";
  }
}

#--------
sub getSalt {
   my ($size) = @_;
   
   my @bb64 = ('A'..'Z' ,'a'..'z', '0'..'9');
   my $salt;
   $size = 2 unless $size;
#warn "getSalt size=$size";
   do {
    $salt .= $bb64[rand($#bb64)];$size--;
#warn "getSalt salt=$salt";
   } while ($size);
   return ($salt);
}
#--------
sub md5pwd {
  my ($txt) = @_;

  my @b64 = (".", "/", '0'..'9', 'A'..'Z' ,'a'..'z');
#  my $salt = $b64[rand($#b64)].$b64[rand($#b64)].$b64[rand($#b64)].$b64[rand($#b64)] .
# 	     $b64[rand($#b64)].$b64[rand($#b64)].$b64[rand($#b64)].$b64[rand($#b64)] ;
  return unix_md5_crypt($txt, getSalt(8));
}
#--------
sub write_log {
  my ($sciper, $code) = @_;
  
  open (LOG, ">>$logfile") or warn "** ERR : write_log: open log file $logfile: $!";
  $code =~ s/\n/ /g;
  printf LOG "%s\t%s\t%s\n", get_time(), $sciper, $code;
  close LOG;
}

#--------
sub loadargs {

  my $query = $ENV{QUERY_STRING};
  my $postdata;
  
  if ($ENV{'REQUEST_METHOD'} && $ENV{'REQUEST_METHOD'} eq 'POST') {
   read (STDIN, $postdata, $ENV{'CONTENT_LENGTH'});
  }
  my $allargs = $query . '&' . $postdata;
  my @fields  = split (/&/, $allargs);
  foreach (@fields) {
    s/\+/ /g;  
    s/%([0-9a-f]{2,2})/pack ("C", hex ($1))/gie;
  }
  my %args;
  foreach my $field (@fields) {
    next unless ($field =~ /=/);  
    my ($name, $value) = split(/=/, $field, 2);  
    $args {$name} .= ' ' if $args {$name};  
    $args {$name} .= "$value";
  }
  %args
}
#--------
sub IsSuperUser {
  my ($mysciper) = @_;
  return 0 unless $mysciper;
  return 1 if ($su_list =~ /$mysciper/);
  return 0;
}
#--------
sub doLog {
  my ($sciper, $msg) = @_;

  return unless $sciper and $msg;
  $msg =~ s/\'/\'\'/g;
  $msg =~ s/\n/ /g;
  my $sql = qq{insert into logs set
  	ts=Now(),
	sciper='$sciper',
	descr='$msg'
  };
  dbquery ($sql) ;
}
#--------
sub dbconnect {

  my $dbname  = 'formcont';
  my $dbuser  = 'formcont';
  my $dbpwd   = $dbuser.'59';
  my $dbhost  = 'cadidb.epfl.ch';

  die "dbconnect : ERR DB CONFIG : $dbname, $dbhost, $dbuser" unless ($dbname and $dbhost and $dbuser and $dbpwd) ;
  my $dsndb    = qq{dbi:mysql:$dbname:$dbhost:3306}; 
warn "dbconnect : $dsndb";
  $dbh = DBI->connect ($dsndb, $dbuser, $dbpwd);
  $dbh->{'mysql_enable_utf8'} = 1;
die "dbconnect : ERR DBI CONNECT : $dbhost, $dbname, $dbuser" unless $dbh;

}
#___________
sub dbquery {
  my ($sql) = @_;

#warn "--> dbquery : $dbname, $sql, params=@params\n";

  dbconnect () unless $dbh;
  my $sth = $dbh->prepare( $sql) or die "database fatal erreur prepare\n$DBI::errstr\n$sql\n";
  $sth->execute () or die "database fatal erreur : execute : $DBI::errstr\n$sql\n";

  return $sth;
}

#--------
sub dbquery_OLD {
  my ($sql) = @_;
  
  my $dbname = 'formcont';
  $dbh	  = dbconnect($dbname) unless $dbh;
  my $sth = $dbh->query ($sql);
  unless ($sth) {
    warn "formcont :: dbquery: ** ERR ** $sql\n";  
    $sth = $dbh->query ($sql);
  }
  return $sth;
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

  my $sql = qq{select * from transact where id='$id_trans'};
  $sql .= qq{ and etat='$etat'} if $etat;
  my $sth = dbquery ($sql) or return;
  return $sth->fetchrow_hashref ();
  
}

sub header {
	print qq{Content-Type: text/html; charset=UTF-8

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta http-equiv="content-type" content="text/html;charset=UTF-8">
    <title>Formation continue UNIL/EPFL</title>

<style type="text/css">
<!--
body {
	font-family: Verdana, Arial, Helvetica, sans-serif;
}
a {
	text-decoration: none;
}
a:hover {
	color: #FF0000;
	text-decoration: none;
}
.copy {
	font-size: smaller;
	color: #999999;
}
-->
</style>

</head>

<body>

<div class="logobox"><a href="http://www.formation-continue-unil-epfl.ch/"><img src="/images/formcont-logo.png" alt="Formation continue UNIL/EPFL" border="0"></a></div>

};
}

sub footer {
	print qq{
		<hr>
		<span class="copy">&copy; 2011 - <a href="http://www.formation-continue-unil-epfl.ch/" target="_blank">Formation continue UNIL-EPFL</a> - <a href=mailto:formcont\@unil.ch>contact</a></span>
	};
}

1;
