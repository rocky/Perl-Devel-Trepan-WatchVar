#!/usr/bin/env perl 
# Copyright (C) 2012 Rocky Bernstein <rocky@cpan.org>
package Devel::Trepan::WatchVar;
our $VERSION='0.9_01';
"All of the real action is in Devel::Trepan::CmdProcessor::Command::WatchVar.pm";
__END__

=pod

=for comment
This file is shared by both WatchVar.pod and WatchVar.pm after
its __END__
WatchVar.pod is useful in the Github wiki:
https://github.com/rocky/Perl-Devel-Trepan-WatchVar/wiki
where we can immediately see the results and others can contribute.

=for comment
The version WatchVar.pm however is what is seen at
https://metacpan.org/module/Devel::Trepan::WatchVar and when folks
download this file.

=head1 NAME

Devel::Trepan::WatchVar

=head1 SUMMARY

Perl Disassembly plugin for L<Devel::Trepan> via L<B::Concise>

=head1 DESCRIPTION

B<watchvar> [I<options>] I<variable>]

I<options>:

    -get
    -set
    -len
    -debug
    -clear
    -free
    -dup
    -store
    -exists
    -delete

I<To be completed...>

=head1 EXAMPLES

I<To be completed...>

=head1 AUTHORS

Rocky Bernstein

=head1 COPYRIGHT

Copyright (C) 2012 Rocky Bernstein <rocky@cpan.org>

This program is distributed WITHOUT ANY WARRANTY, including but not
limited to the implied warranties of merchantability or fitness for a
particular purpose.

The program is free software. You may distribute it and/or modify it
under the terms of the GNU General Public License as published by the
Free Software Foundation (either version 2 or any later version) and
the Perl Artistic License as published by O'Reilly Media, Inc. Please
open the files named gpl-2.0.txt and Artistic for a copy of these
licenses.

=cut
