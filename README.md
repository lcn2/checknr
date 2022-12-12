# checknr — check nroff/troff files

The checknr utility checks a list of nroff(1) or troff(1) input files for certain kinds of errors 
involving mismatched opening and closing delimiters and unknown commands.


# To install 

1. make clobber
2. make all
3. make test

If all is well:

4. make install

NOTE: You may have to be root to install.


# To use

See the `checknr.1` man page for details.

To read the `checknr.1` man page before installing:

```sh
man ./checknr.1
```

For example, to check the `checknr.1` man page within the source directory:

```sh
./checknr -c.Ar.Bd.Bl.Bx.Dd.Dt.Ed.El.Fl.It.Nd.Nm.Op.Os.Pp.Ql.Sh.Sq.Xr checknr.1
```

From the [dbg repo](https://github.com/lcn2/dbg/) man page
[dbg.3](https://github.com/lcn2/dbg/blob/master/dbg.3) try:

```sh
checknr -c.BR.SS.BI /path/to/dbg/dbg.3
```

The above command assumes you have installed `checknr` and that the
executable is in the path.

To test from this directory:

```sh
./checknr -c.BR.SS.BI /path/to/dbg/dbg.3
```


# History

Landon Noll did NOT write checknr.  This repo is provided by Landon Noll so that others may use this old command.

The checknr command first appeared in 4.0BSD.  The original 4.0BSD source code contains these strings:

```
@(#) Copyright (c) 1980, 1993
	The Regents of the University of California.  All rights reserved.
@(#)checknr.c   8.1 (Berkeley) 6/6/93
```

Later on, this line was added by the folks from FreeBSD:

```
$FreeBSD: src/usr.bin/checknr/checknr.c,v 1.9 2004/07/15 04:42:47 tjr Exp

The program had to be modified slightly from the FreeBSD version, to make it easier for other systems to compile.  See the file [checknr.orig.c](https://github.com/lcn2/checknr/blob/master/checknr.orig.c) for the original source code.
