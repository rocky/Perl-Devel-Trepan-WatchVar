# -*- coding: utf-8 -*-
# Copyright (C) 2012 Rocky Bernstein <rocky@cpan.org>
use warnings; no warnings 'redefine';

use rlib '../../../..';

# Our local modules

package Devel::Trepan::CmdProcessor::Command::WatchVar;

## FIXME:: Make conditional

use Getopt::Long qw(GetOptionsFromArray);
use Variable::Magic qw<wizard cast VMG_OP_INFO_NAME>;

use if !@ISA, Devel::Trepan::CmdProcessor::Command ;

unless (@ISA) {
    eval <<"EOE";
    use constant CATEGORY   => 'breakpoints';
    use constant SHORT_HELP => 'WatchVar subroutine(s)';
    use constant MIN_ARGS  => 0;  # Need at least this many
    use constant MAX_ARGS  => undef;  # Need at most this many - undef -> unlimited.
    use constant NEED_STACK => 1;

EOE
}

use strict;

use vars qw(@ISA $DEFAULT_OPTIONS @WATCH_TRACKER); 
@ISA = qw(Devel::Trepan::CmdProcessor::Command); 
@WATCH_TRACKER = ();

use vars @CMD_VARS;  # Value inherited from parent

$DEFAULT_OPTIONS = { 
    set => 1,
};

our $NAME = set_name();
our $HELP = <<'HELP';
=pod

B<watchvar> [I<options>] I<variable>

I<options>: 

    -get
    -set
    -len
    -clear
    -free
    -dup
    -store
    -exists
    -delete

I<To be completed...>

=cut
HELP

sub complete($$) 
{
    no warnings 'once';
    my ($self, $prefix) = @_;
    my @subs = keys %DB::sub;
    my @opts = (qw(-get -set -len -clear -free -dup
                   -store -exists -delete),
		@subs);
    Devel::Trepan::Complete::complete_token(\@opts, $prefix) ;
}
    
sub parse_options($$)
{
    my ($self, $args) = @_;
    my $opts = $DEFAULT_OPTIONS;
    my $result = &GetOptionsFromArray(
	$args,
	'-get'     => sub { $opts->{get}    = 1 },
	'-set'     => sub { $opts->{set}    = 1 },
	'-len'     => sub { $opts->{len}    = 1 },
	'-clear'   => sub { $opts->{clear}  = 1 },
	'-free'    => sub { $opts->{free}   = 1 },
	'-dup'     => sub { $opts->{dup}    = 1 },
	'-store'   => sub { $opts->{store}  = 1 },
	'-exists'  => sub { $opts->{exists} = 1 },
	'-delete'  => sub { $opts->{delete} = 1 },
	);
    $opts;
}


sub run($$)
{
    my ($self, $args) = @_;
    my @args = @$args;
    shift @args;
    my $proc = $self->{proc};
    my $wiz = wizard(
	set  => sub { print "$args[0] now set to ${$_[0]}\n" },
	free => sub { print "$args[0] destroyed\n" }
	);
    push @WATCH_TRACKER, $wiz;
    my $code_to_eval = 
	sprintf("Variable::Magic::cast %s, \$%s::WATCH_TRACKER[-1]", 
		$args[0], __PACKAGE__);
    my $opts = {return_type => ';'};
    $proc->eval($code_to_eval, $opts, 4);
}

  
# Demo it
unless (caller) {

    require Devel::Trepan::CmdProcessor;
    eval { use Devel::Callsite };
    my $proc = Devel::Trepan::CmdProcessor->new(undef, 'bogus');
    my $cmd = __PACKAGE__->new($proc);
    eval {
        sub create_frame() {
            my ($pkg, $file, $line, $fn) = caller(0);
	    no warnings 'once';
            $DB::package = $pkg;
            return [
                {
                    file      => $file,
                    fn        => $fn,
                    line      => $line,
                    pkg       => $pkg,
                }];
        }
    };
    my $x = 1;
    # $cmd->run([$NAME, '$x']);
    $x = 2;
}

1;
