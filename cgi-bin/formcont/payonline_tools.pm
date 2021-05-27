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
            $su_list $ges_list $SHAsalt $mode $formContent $postURL $redirectURL $URLcgi
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

$YPServersIP	= '185.8.54.254,185.8.52.254,194.41.152.138,194.41.152.139,194.41.216.138,194.41.216.139,212.23.45.96,212.23.45.97,212.23.45.98,212.23.45.99,212.23.45.100,212.23.45.101,212.23.45.102,212.23.45.103,212.23.45.104,212.23.45.105,212.23.45.106,212.23.45.107,212.23.45.108,212.23.45.109,212.23.45.110,212.23.45.111 ,213.254.248.96,213.254.248.97,213.254.248.98,213.254.248.99,213.254.248.100,213.254.248.101,213.254.248.102,213.254.248.103,213.254.248.104,213.254.248.105,213.254.248.106,213.254.248.107,213.254.248.108,213.254.248.109,213.254.248.110,213.254.248.111 ,212.35.124.160,212.35.124.161,212.35.124.162,212.35.124.163,212.35.124.164,212.35.124.165,212.35.124.166,212.35.124.167,212.35.124.168,212.35.124.169,212.35.124.170,212.35.124.171,212.35.124.172,212.35.124.173,212.35.124.174,212.35.124.175';

$su_list	= '104782';	# - ic,

$DEBUG 		= '0';
$mode   	= $DEBUG ? 'test' : 'prod';	# - test | prod
$ShopID 	= $DEBUG ? 'unilepflTEST' : 'unilepfl';	# - test | prod
$URLcgi		= $DEBUG ? '/cgi-bin/formcont/test/payment' : '/cgi-bin/formcont/payment';

warn "formcont :: DEBUG=$DEBUG\n";

$postURL	= 'https://isatest.epfl.ch/imoniteur_ISAT/!itf.formulaires.payonlineFCUE';
$redirectURL= 'https://isatest.epfl.ch/imoniteur_ISAT/!itf.formulaires.redirectFCUE';

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

warn "formcont DEBUG=$DEBUG  : send_mail : $dest, $subj\n";
  return if $DEBUG;
  
  my %mail;
  $mail{From} = 'noreply@epfl.ch'; 
  $mail{Bcc}  = 'formcont@epfl.ch';
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
  my $dbhost  = $DEBUG ? 'test-cadidb.epfl.ch' : 'cadidb.epfl.ch';

  die "dbconnect : ERR DB CONFIG : $dbname, $dbhost, $dbuser" unless ($dbname and $dbhost and $dbuser and $dbpwd) ;
  my $dsndb    = qq{dbi:mysql:$dbname:$dbhost:3306}; 
warn "dbconnect : $dsndb";
  $dbh = DBI->connect ($dsndb, $dbuser, $dbpwd, {mysql_enable_utf8 => 1});
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

#--------
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

<div class="logobox"><a href="http://www.formation-continue-unil-epfl.ch/"><img src="https://payonline.epfl.ch/images/formcont-logo.png" alt="Formation continue UNIL/EPFL" border="0"></a></div>
};
}

#--------
sub footer {
	print qq{
		<hr>
		<span class="copy">&copy; 2011 - <a href="http://www.formation-continue-unil-epfl.ch/" target="_blank">Formation continue UNIL-EPFL</a> - <a href=mailto:formcont\@unil.ch>contact</a></span>
	};
}

my $select_country = qq{
<select name="Country" id="Country">
        <option value="" selected>select...</option>
        <option value="AF" >Afghanistan</option>
        <option value="AL" >Albania</option>
        <option value="DZ" >Algeria</option>
        <option value="AS" >American Samoa</option>
        <option value="AD" >Andorra</option>
        <option value="AO" >Angola</option>
        <option value="AI" >Anguilla</option>
        <option value="AQ" >Antarctica</option>
        <option value="AG" >Antigua and Barbuda</option>
        <option value="AR" >Argentina</option>
        <option value="AM" >Armenia</option>
        <option value="AW" >Aruba</option>
        <option value="AU" >Australia</option>
        <option value="AT" >Austria</option>
        <option value="AZ" >Azerbaijan</option>
        <option value="BS" >Bahamas</option>
        <option value="BH" >Bahrain</option>
        <option value="BD" >Bangladesh</option>
        <option value="BB" >Barbados</option>
        <option value="BY" >Belarus</option>
        <option value="BE" >Belgium</option>
        <option value="BZ" >Belize</option>
        <option value="BJ" >Benin</option>
        <option value="BM" >Bermuda</option>
        <option value="BT" >Bhutan</option>
        <option value="BO" >Bolivia</option>
        <option value="BA" >Bosnia and Herzegowina</option>
        <option value="BW" >Botswana</option>
        <option value="BV" >Bouvet Island</option>
        <option value="BR" >Brazil</option>
        <option value="IO" >British Indian Ocean Territory</option>
        <option value="BN" >Brunei Darussalam</option>
        <option value="BG" >Bulgaria</option>
        <option value="BF" >Burkina Faso</option>
        <option value="BI" >Burundi</option>
        <option value="KH" >Cambodia</option>
        <option value="CM" >Cameroon</option>
        <option value="CA" >Canada</option>
        <option value="CV" >Cape Verde</option>
        <option value="KY" >Cayman Islands</option>
        <option value="CF" >Central African Republic</option>
        <option value="TD" >Chad</option>
        <option value="CL" >Chile</option>
        <option value="CN" >China</option>
        <option value="CX" >Christmas Island</option>
        <option value="CC" >Cocos (Keeling) Islands</option>
        <option value="CO" >Colombia</option>
        <option value="KM" >Comoros</option>
        <option value="CG" >Congo</option>
        <option value="CD" >Congo, The Democratic Republic of the</option>
        <option value="CK" >Cook Islands</option>
        <option value="CR" >Costa Rica</option>
        <option value="CI" >Cote d'Ivoire</option>
        <option value="HR" >Croatia (Hrvatska)</option>
        <option value="CU" >Cuba</option>
        <option value="CY" >Cyprus</option>
        <option value="CZ" >Czech Republic</option>
        <option value="DK" >Denmark</option>
        <option value="DJ" >Djibouti</option>
        <option value="DM" >Dominica</option>
        <option value="DO" >Dominican Republic</option>
        <option value="TP" >East Timor</option>
        <option value="EC" >Ecuador</option>
        <option value="EG" >Egypt</option>
        <option value="SV" >El Salvador</option>
        <option value="GQ" >Equatorial Guinea</option>
        <option value="ER" >Eritrea</option>
        <option value="EE" >Estonia</option>
        <option value="ET" >Ethiopia</option>
        <option value="FK" >Falkland Islands (Malvinas)</option>
        <option value="FO" >Faroe Islands</option>
        <option value="FJ" >Fiji</option>
        <option value="FI" >Finland</option>
        <option value="FR" >France</option>
        <option value="FX" >France, Metropolitan</option>
        <option value="GF" >French Guiana</option>
        <option value="PF" >French Polynesia</option>
        <option value="TF" >French Southern Territories</option>
        <option value="GA" >Gabon</option>
        <option value="GM" >Gambia</option>
        <option value="GE" >Georgia</option>
        <option value="DE" >Germany</option>
        <option value="GH" >Ghana</option>
        <option value="GI" >Gibraltar</option>
        <option value="GR" >Greece</option>
        <option value="GL" >Greenland</option>
        <option value="GD" >Grenada</option>
        <option value="GP" >Guadeloupe</option>
        <option value="GU" >Guam</option>
        <option value="GT" >Guatemala</option>
        <option value="GN" >Guinea</option>
        <option value="GW" >Guinea-Bissau</option>
        <option value="GY" >Guyana</option>
        <option value="HT" >Haiti</option>
        <option value="HM" >Heard and Mc Donald Islands</option>
        <option value="VA" >Holy See (Vatican City State)</option>
        <option value="HN" >Honduras</option>
        <option value="HK" >Hong Kong</option>
        <option value="HU" >Hungary</option>
        <option value="IS" >Iceland</option>
        <option value="IN" >India</option>
        <option value="ID" >Indonesia</option>
        <option value="IR" >Iran (Islamic Republic of)</option>
        <option value="IQ" >Iraq</option>
        <option value="IE" >Ireland</option>
        <option value="IL" >Israel</option>
        <option value="IT" >Italy</option>
        <option value="JM" >Jamaica</option>
        <option value="JP" >Japan</option>
        <option value="JO" >Jordan</option>
        <option value="KZ" >Kazakhstan</option>
        <option value="KE" >Kenya</option>
        <option value="KI" >Kiribati</option>
        <option value="KP" >Korea, Democratic People's Republic of</option>
        <option value="KR" >Korea, Republic of</option>
        <option value="KW" >Kuwait</option>
        <option value="KG" >Kyrgyzstan</option>
        <option value="LA" >Lao People's Democratic Republic</option>
        <option value="LV" >Latvia</option>
        <option value="LB" >Lebanon</option>
        <option value="LS" >Lesotho</option>
        <option value="LR" >Liberia</option>
        <option value="LY" >Libyan Arab Jamahiriya</option>
        <option value="LI" >Liechtenstein</option>
        <option value="LT" >Lithuania</option>
        <option value="LU" >Luxembourg</option>
        <option value="MO" >Macau</option>
        <option value="MK" >Macedonia, The Former Yugoslav Republic of</option>
        <option value="MG" >Madagascar</option>
        <option value="MW" >Malawi</option>
        <option value="MY" >Malaysia</option>
        <option value="MV" >Maldives</option>
        <option value="ML" >Mali</option>
        <option value="MT" >Malta</option>
        <option value="MH" >Marshall Islands</option>
        <option value="MQ" >Martinique</option>
        <option value="MR" >Mauritania</option>
        <option value="MU" >Mauritius</option>
        <option value="YT" >Mayotte</option>
        <option value="MX" >Mexico</option>
        <option value="FM" >Micronesia, Federated States of</option>
        <option value="MD" >Moldova, Republic of</option>
        <option value="MC" >Monaco</option>
        <option value="MN" >Mongolia</option>
        <option value="MS" >Montserrat</option>
        <option value="MA" >Morocco</option>
        <option value="MZ" >Mozambique</option>
        <option value="MM" >Myanmar</option>
        <option value="NA" >Namibia</option>
        <option value="NR" >Nauru</option>
        <option value="NP" >Nepal</option>
        <option value="NL" >Netherlands</option>
        <option value="AN" >Netherlands Antilles</option>
        <option value="NC" >New Caledonia</option>
        <option value="NZ" >New Zealand</option>
        <option value="NI" >Nicaragua</option>
        <option value="NE" >Niger</option>
        <option value="NG" >Nigeria</option>
        <option value="NU" >Niue</option>
        <option value="NF" >Norfolk Island</option>
        <option value="MP" >Northern Mariana Islands</option>
        <option value="NO" >Norway</option>
        <option value="OM" >Oman</option>
        <option value="PK" >Pakistan</option>
        <option value="PW" >Palau</option>
        <option value="PA" >Panama</option>
        <option value="PG" >Papua New Guinea</option>
        <option value="PY" >Paraguay</option>
        <option value="PE" >Peru</option>
        <option value="PH" >Philippines</option>
        <option value="PN" >Pitcairn</option>
        <option value="PL" >Poland</option>
        <option value="PT" >Portugal</option>
        <option value="PR" >Puerto Rico</option>
        <option value="QA" >Qatar</option>
        <option value="RE" >Reunion</option>
        <option value="RO" >Romania</option>
        <option value="RU" >Russian Federation</option>
        <option value="RW" >Rwanda</option>
        <option value="KN" >Saint Kitts and Nevis</option>
        <option value="LC" >Saint Lucia</option>
        <option value="VC" >Saint Vincent and the Grenadines</option>
        <option value="WS" >Samoa</option>
        <option value="SM" >San Marino</option>
        <option value="ST" >Sao Tome and Principe</option>
        <option value="SA" >Saudi Arabia</option>
        <option value="SN" >Senegal</option>
        <option value="SC" >Seychelles</option>
        <option value="SL" >Sierra Leone</option>
        <option value="SG" >Singapore</option>
        <option value="SK" >Slovakia (Slovak Republic)</option>
        <option value="SI" >Slovenia</option>
        <option value="SB" >Solomon Islands</option>
        <option value="SO" >Somalia</option>
        <option value="ZA" >South Africa</option>
        <option value="GS" >South Georgia and the South Sandwich Islands</option>
        <option value="ES" >Spain</option>
        <option value="LK" >Sri Lanka</option>
        <option value="SH" >St. Helena</option>
        <option value="PM" >St. Pierre and Miquelon</option>
        <option value="SD" >Sudan</option>
        <option value="SR" >Suriname</option>
        <option value="SJ" >Svalbard and Jan Mayen Islands</option>
        <option value="SZ" >Swaziland</option>
        <option value="SE" >Sweden</option>
        <option value="CH" >Switzerland</option>
        <option value="SY" >Syrian Arab Republic</option>
        <option value="TW" >Taiwan, Province of China</option>
        <option value="TJ" >Tajikistan</option>
        <option value="TZ" >Tanzania, United Republic of</option>
        <option value="TH" >Thailand</option>
        <option value="TG" >Togo</option>
        <option value="TK" >Tokelau</option>
        <option value="TO" >Tonga</option>
        <option value="TT" >Trinidad and Tobago</option>
        <option value="TN" >Tunisia</option>
        <option value="TR" >Turkey</option>
        <option value="TM" >Turkmenistan</option>
        <option value="TC" >Turks and Caicos Islands</option>
        <option value="TV" >Tuvalu</option>
        <option value="UG" >Uganda</option>
        <option value="UA" >Ukraine</option>
        <option value="AE" >United Arab Emirates</option>
        <option value="GB" >United Kingdom</option>
        <option value="US" >United States</option>
        <option value="UM" >United States Minor Outlying Islands</option>
        <option value="UY" >Uruguay</option>
        <option value="UZ" >Uzbekistan</option>
        <option value="VU" >Vanuatu</option>
        <option value="VE" >Venezuela</option>
        <option value="VN" >Viet Nam</option>
        <option value="VG" >Virgin Islands (British)</option>
        <option value="VI" >Virgin Islands (U.S.)</option>
        <option value="WF" >Wallis and Futuna Islands</option>
        <option value="EH" >Western Sahara</option>
        <option value="YE" >Yemen</option>
        <option value="YU" >Yugoslavia</option>
        <option value="ZM" >Zambia</option>
        <option value="ZW" >Zimbabwe</option>
      </select>
};
$formContent = {
	fr => qq{
<p>Veuillez remplir tous les champs ci-desssous : </p>
<form id="form1" name="cmd" method="post" action="$URLcgi"
OnSubmit=" 
		 if (document.cmd.condgen.checked) {
			document.cmd.submit();
		 } else {
			alert ('Lire les Conditions Générales et cocher la case pour continuer');
			return false; 
		 }
		 " enctype="multipart/form-data">
  <input type=hidden name=lang value=en>
  <table width="100%" border="0" cellpadding="5">
    <tr>
      <td width="30%"><div align="right"><strong>Nom</strong></div></td>
      <td width="70%"><input name="LastName" type="text" id="lastname" size="48" /></td>
    </tr>
    <tr>
      <td><div align="right"><strong>Prénom</strong></div></td>
      <td><input name="FirstName" type="text" id="firstname" size="48" /></td>
    </tr>
    <tr>
      <td><div align="right"><strong>Adresse</strong></div></td>
      <td><input name="Addr" type="text" id="addr" size="48" /></td>
    </tr>
    <tr>
      <td><div align="right"><strong>Code postal</strong></div></td>
      <td><input name="Zip" type="text" id="zip" size="8" /></td>
    </tr>
    <tr>
      <td><div align="right"><strong>Ville</strong></div></td>
      <td><input name="City" type="text" id="city" size="48" /></td>
    </tr>
    <tr>
      <td><div align="right"><strong>Pays</strong></div></td>
      <td>$select_country</td>
    </tr>
    <tr>
      <td><div align="right"><strong>Email</strong></div></td>
      <td><input name="Email" type="text" id="email" size="48" /></td>
    </tr>
  </table>

<table width="100%" border="0" cellpadding="5">
  <tr>
    <td width="30%"><div align="right"><strong>Numéro de participant</strong></div></td>
    <td width="70%"><input name="nopernum" type="text" id="nopernum" value="NUM_PART"/></td>
  </tr>
  <tr>
    <td><div align="right"><strong>Numéro de facture</strong></div></td>
    <td><input name="nofacture" type="text" id="nofacture"  value="NUM_FACTURE"/></td>
  </tr>

	},
	en => qq{
<p>Please fill in all the fields here below : </p>
<form id="form1" name="cmd" method="post" action="$URLcgi"
OnSubmit=" 
		 if (document.cmd.condgen.checked) {
			document.cmd.submit();
		 } else {
			alert ('Please read the General Terms and check the bxo to continue');
			return false; 
		 }
		 " enctype="multipart/form-data">
  <input type=hidden name=lang value=en>
  <table width="100%" border="0" cellpadding="5">
    <tr>
      <td width="30%"><div align="right"><strong>Lastname</strong></div></td>
      <td width="70%"><input name="LastName" type="text" id="lastname" size="48" /></td>
    </tr>
    <tr>
      <td><div align="right"><strong>Firstname</strong></div></td>
      <td><input name="FirstName" type="text" id="firstname" size="48" /></td>
    </tr>
    <tr>
      <td><div align="right"><strong>Address</strong></div></td>
      <td><input name="Addr" type="text" id="addr" size="48" /></td>
    </tr>
    <tr>
      <td><div align="right"><strong>Zip code</strong></div></td>
      <td><input name="Zip" type="text" id="zip" size="8" /></td>
    </tr>
    <tr>
      <td><div align="right"><strong>City</strong></div></td>
      <td><input name="City" type="text" id="city" size="48" /></td>
    </tr>
    <tr>
      <td><div align="right"><strong>Country</strong></div></td>
      <td>$select_country</td>
    </tr>
    <tr>
      <td><div align="right"><strong>Email</strong></div></td>
      <td><input name="Email" type="text" id="email" size="48" /></td>
    </tr>
  </table>

<table width="100%" border="0" cellpadding="5">
  <tr>
    <td width="30%"><div align="right"><strong>Participant NR</strong></div></td>
    <td width="70%"><input name="nopernum" type="text" id="nopernum" value="NUM_PART"/></td>
  </tr>
  <tr>
    <td><div align="right"><strong>Invoice number </strong></div></td>
    <td><input name="nofacture" type="text" id="nofacture"  value="NUM_FACTURE"/></td>
  </tr>
	}
};


1;
