package formcont_tools;
use payonline_tools;
use Encode;

use vars qw($postURL $redirectURL);

$postURL	= 'https://isatest.epfl.ch/imoniteur_ISAT/!itf.formulaires.payonlineFCUE';
$redirectURL= 'https://isatest.epfl.ch/imoniteur_ISAT/!itf.formulaires.redirectFCUE';


sub is_prod {
  ! $ENV{FORMCONT_TEST_MODE}
}

#--------
my $dbh;
sub dbconnect {
  $dbh = payonline_tools::dbconnect('formcont');
}
#___________
sub dbquery {
  my ($sql) = @_;

  log_event "dbquery", sql => $sql;

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
  $mail{"Content-Type"} = 'text/plain; charset="utf-8"';
  $mail{Subject} = Encode::encode('utf8', $subj);
  $mail{Message} = Encode::encode('utf8', $msg);

  $log_event = "formcont::send_mail";
  if (sendmail (%mail)) {
     if ($Mail::Sendmail::error) {
       log_event $log_event, error => $Mail::Sendmail::error;
     } else {
       $msg =~ s/\n/;/g;
       log_event $log_event, to => $mail{To}, subject => $subj;
     }
  } else {
    log_event $log_event, status => "failed", error => $Mail::Sendmail::error;
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
