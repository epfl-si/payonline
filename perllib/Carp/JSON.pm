#!/usr/bin/perl -w

=head1 NAME

B<Carp::JSON> — Like L<Carp::Always>, except in JSON.

=head1 CREDITS

More than half the code is copied straight out of L<Carp::Always>, as
the license permits. Redistribution is hereby permitted under the
terms of either the GNU General Public License version 1, or (at your
option) any later version, or the Artistic License.

=cut

package Carp::JSON;

use 5.006;
use strict;
use warnings;
use JSON qw(encode_json);

our $VERSION = '0.16';

BEGIN {
  require Carp;
  $Carp::CarpInternal{ +__PACKAGE__ }++;
}

use constant CHOMP_DOT => $Carp::VERSION < 1.25;

sub _warn { warn &_longmess }

sub _die { die ref $_[0] ? @_ : &_longmess }

sub _longmess {
  if (CHOMP_DOT && $_[-1] =~ /\.\n\z/) {
    my $arg = pop @_;
    $arg =~ s/\.\n\z/\n/;
    push @_, $arg;
  }
  my $mess = &Carp::longmess;
  $mess =~ s/( at .*?\n)\1/$1/s;    # Suppress duplicate tracebacks
  my @stacktrace = split(qr/ (?:called )?at (.*?\n)/s, $mess);
  my $message = shift @stacktrace;
  unshift @stacktrace, ".";
  my @stack;
  while(my ($what, $where) = splice(@stacktrace, 0, 2)) {
    $what =~ s/^\s+//;
    chomp($where);
    if (my ($file, $line) = $where =~ m/^(.*) line (\d+)/) {
      push @stack, { what => $what, file => $file, line => $line };
    } else {
      push @stack, { what => $what, where => $where };
    }
  }
  encode_json({ stacktrace => { message => $message, stack => \@stack }}) . "\n";
}

my @HOOKS = qw(__DIE__ __WARN__);
my %OLD_SIG;

sub import {
  my $class = shift;
  return if $OLD_SIG{$class};
  @{ $OLD_SIG{$class} }{ @HOOKS, 'Verbose' } = (@SIG{@HOOKS}, $Carp::Verbose);

  @SIG{@HOOKS} = ($class->can('_die'), $class->can('_warn'));
  $Carp::Verbose = 'verbose';    # makes carp() cluck and croak() confess
}

sub unimport {
  my $class = shift;
  return unless $OLD_SIG{$class};
  no if "$]" <= 5.008008, 'warnings' => 'uninitialized';
  (@SIG{@HOOKS}, $Carp::Verbose) = @{ delete $OLD_SIG{$class} }{ @HOOKS, 'Verbose' };
}

1;
