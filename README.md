Devel::Trepan::WatchVar -- Devel::Trepan variable watch plugin for via Variable::Magic 
====================================================================

SYNOPSIS
--------

This adds a `watchvar` command to the Devel::Trepan debugger.
This plugin uses [Variable::Magic](https://metacpan.org/module/Variable::Magic) to do the heavy lifting.
See "help" inside the debugger or a list of options.

INSTALLATION
------------

To install this Devel::Trepan, run the following commands:

	perl Build.PL
	make
	make test
	[sudo] make install

LICENSE AND COPYRIGHT
---------------------

Copyright (C) 2012 Rocky Bernstein <rocky@cpan.org>

This program is distributed WITHOUT ANY WARRANTY, including but not
limited to the implied warranties of merchantability or fitness for a
particular purpose.

The program is free software. You may distribute it and/or modify it
under the terms of the GNU General Public License as published by the
Free Software Foundation (either version 2 or any later version) and
the Perl Artistic License as published by O’Reilly Media, Inc. Please
open the files named gpl-2.0.txt and Artistic for a copy of these
licenses.

