package formcont_tools;
use payonline_tools;
use v5.10;  # For say()

use vars qw($postURL $redirectURL);

$postURL	= 'https://isatest.epfl.ch/imoniteur_ISAT/!itf.formulaires.payonlineFCUE';
$redirectURL= 'https://isatest.epfl.ch/imoniteur_ISAT/!itf.formulaires.redirectFCUE';


sub is_prod {
  ! $ENV{FORMCONT_TEST_MODE}
}

#--------
my $dbh;
sub dbconnect {

  my $dbname  = 'formcont';
  my $dbuser  = 'formcont';
  my $dbpwd   = $dbuser.'59';
  my $dbhost  = is_prod ? 'test-cadidb.epfl.ch' : 'cadidb.epfl.ch';

  die "dbconnect : ERR DB CONFIG : $dbname, $dbhost, $dbuser" unless ($dbname and $dbhost and $dbuser and $dbpwd) ;
  my $dsndb    = qq{dbi:mysql:$dbname:$dbhost:3306};
say STDERR "dbconnect : $dsndb";
  $dbh = DBI->connect ($dsndb, $dbuser, $dbpwd, {mysql_enable_utf8 => 1});
die "dbconnect : ERR DBI CONNECT : $dbhost, $dbname, $dbuser" unless $dbh;

}
#___________
sub dbquery {
  my ($sql) = @_;

#say STDERR "--> dbquery : $dbname, $sql, params=@params\n";

  dbconnect () unless $dbh;
  my $sth = $dbh->prepare( $sql) or die "database fatal erreur prepare\n$DBI::errstr\n$sql\n";
  $sth->execute () or die "database fatal erreur : execute : $DBI::errstr\n$sql\n";

  return $sth;
}
#--------
sub send_mail {
  return unless is_prod;
  my ($dest, $subj, $msg) = @_;

  my %mail;
  $mail{From} = 'noreply@epfl.ch';
  $mail{Bcc}  = 'formcont@epfl.ch';
  $mail{To}   = $dest;

  $mail{Smtp} 	 = 'mail.epfl.ch';
  $mail{Subject} = $subj;
  $mail{Message} = $msg;
  if (sendmail (%mail)) {
     if ($Mail::Sendmail::error) {
		say STDERR "formcont :: send_mail : **ERROR** : $Mail::Sendmail::error\n";
     } else {
		$msg =~ s/\n/;/g;
		say STDERR "formcont :: send_mail : $mail{To}, SUBJ: $subj\n";
     }
  } else {
		say STDERR "formcont :: send_mail : **ERROR** : $Mail::Sendmail::error\n";
  }
}

package YellowPayFlow::FormCont;

use base qw(YellowPayFlow);

sub test {
  bless {
    shopID => 'unilepflTEST',
    hmac_in => $payonline_tools::HMAC_salts->{unil}->{in},
    hmac_out => $payonline_tools::HMAC_salts->{unil}->{out},
    srv => YellowPayFlow::_postfinance_srv("test"),
  }, shift
}

sub prod {
  bless {
    shopID => 'unilepfl',
    hmac_in => $payonline_tools::HMAC_salts->{unil}->{in},
    hmac_out => $payonline_tools::HMAC_salts->{unil}->{out},
    srv => YellowPayFlow::_postfinance_srv("prod"),
  }, shift
}

sub makeHash {
  my ($self, $struct) = @_;
  return YellowPayFlow::_makeHash($struct,
                                  exists $struct->{PAYID} ?
                                  $self->{hmac_out} :
                                  $self->{hmac_in});
}

sub current {
  my ($class, $mode) = @_;
  formcont_tools::is_prod ? $class->prod : $class->test;
}

1;
