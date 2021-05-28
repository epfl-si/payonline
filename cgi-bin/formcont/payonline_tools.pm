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
use formcont_tools;

use DBI;
use Net::LDAP;
use Mail::Sendmail;
use Digest::MD5 qw(md5_hex);
use Digest::SHA1 ;

use strict;
use vars qw( $dbh $DEBUG $su_list $errmsg $demfond $codeTVA
            $YellowPayPrdSrv $YellowPayTstSrv $YellowPaySrv $YPServersIP $ShopID $tmpldir 
            $ges_list $SHAsalt $postURL $redirectURL
            );

my $me 		= $ENV {SCRIPT_NAME};
my $us 		= $ENV {SERVER_NAME};
my $qs 		= $ENV {QUERY_STRING};
my $pi 		= $ENV {PATH_INFO};
my @days 	= (0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
my $resp 	= 'ion.cionca@epfl.ch';

$DEBUG 		= '0';


warn "formcont :: DEBUG=$DEBUG\n";

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
sub get_time {
  my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
  $mon++;
  $year += 1900;
  $days[2] = 29 if ($year % 400 == 0) || ($year % 4 == 0 && $year % 100 != 0) ;
  return sprintf "%4d-%02d-%02d %02d:%02d:00",$year,$mon,$mday,$hour,$min;
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
  
  foreach my $item (sort keys %$params) {
   warn "formcont : DEBUG::$item=$params->{$item}=\n";
  }
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

1;
