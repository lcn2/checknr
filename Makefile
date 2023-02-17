#!/usr/bin/env make
#
# checknr - check nroff/troff files
#
# This Makefile only is:
# Copyright (c) 2022,2023 by Landon Curt Noll.  All Rights Reserved.
#
# Permission to use, copy, modify, and distribute this software and
# its documentation for any purpose and without fee is hereby granted,
# provided that the above copyright, this permission notice and text
# this comment, and the disclaimer below appear in all of the following:
#
#       supporting documentation
#       source copies
#       source works derived from this source
#       binaries derived from this source or from derived source
#
# LANDON CURT NOLL DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
# INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO
# EVENT SHALL LANDON CURT NOLL BE LIABLE FOR ANY SPECIAL, INDIRECT OR
# CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF
# USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.
#
# chongo (Landon Curt Noll, http://www.isthe.com/chongo/index.html) /\oo/\
#
# Share and enjoy! :-)


#############
# utilities #
#############

# suggestion: List utility filenames, not paths.
#	      Do not list shell builtin (echo, cd, ...) tools.
#	      Keep the list in alphabetical order.
#
AR= ar
CAT= cat
CC= cc
CHECKNR= checknr
CP= cp
CTAGS= ctags
GREP= grep
INSTALL= install
RANLIB= ranlib
RM= rm
SHELL= bash


##################
# How to compile #
##################

# C source standards being used
#
# This repo supports c11 and later.
#
# NOTE: The use of -std=gnu11 is because there are a few older systems
#       in late 2021 that do not have compilers that (yet) support gnu17.
#       While there may be even more out of date systems that do not
#       support gnu11, we have to draw the line somewhere.
#
#       --------------------------------------------------
#
#       ^^ the line is above :-)
#
# TODO - ###################################################################### - TODO #
# TODO - In 2023 we will will support only c17 so C_STD will become -std=gnu17  - TODO #
# TODO - ###################################################################### - TODO #
#
C_STD= -std=gnu11
#C_STD= -std=gnu17

# optimization and debug level
#
C_OPT= -O3 -g3
#C_OPT= -O0 -g

# Compiler warnings
#
WARN_FLAGS= -pedantic -Wall -Wextra -Wno-unused-const-variable
#WARN_FLAGS= -pedantic -Wall -Wextra -Werror -Wno-unused-const-variable

# linker options
#
LDFLAGS=

# how to compile
#
# NOTE: If you use ASAN, set this environment var:
#       ASAN_OPTIONS="detect_stack_use_after_return=1"
#
CFLAGS= ${C_STD} ${C_OPT} ${WARN_FLAGS} ${LDFLAGS}
#CFLAGS= ${C_STD} -O0 -g ${WARN_FLAGS} ${LDFLAGS} -fsanitize=address -fno-omit-frame-pointer


###############
# source code #
###############

# source files that are permanent (not made, nor removed)
#
C_SRC= checknr.c
H_SRC=
ALL_SRC= ${C_SRC} ${H_SRC}


######################
# intermediate files #
######################

# NOTE: ${LIB_OBJS} are objects to put into a library and removed by make clean
#
LIB_OBJS=

# NOTE: ${OTHER_OBJS} are objects NOT put into a library and removed by make clean
#
OTHER_OBJS=

# NOTE: intermediate files to make and removed by make clean
#
BUILT_C_SRC=
BUILT_H_SRC=
ALL_BUILT_SRC= ${BUILT_C_SRC} ${BUILT_H_SRC}

# all intermediate files and removed by make clean
#
ALL_OBJS= ${LIB_OBJS} ${OTHER_OBJS}


#######################
# install information #
#######################

# where to install
#
MAN1_DIR= /usr/local/share/man/man1
MAN3_DIR= /usr/local/share/man/man3
MAN8_DIR= /usr/local/share/man/man8
DEST_INCLUDE= /usr/local/include
DEST_LIB= /usr/local/lib
DEST_DIR= /usr/local/bin


#################################
# external Makefile information #
#################################

# may be used outside of this directory
#
EXTERN_H=
EXTERN_O=
EXTERN_MAN= ${ALL_MAN_TARGETS}
EXTERN_LIBA=

# NOTE: ${EXTERN_CLOBBER} used outside of this directory and removed by make clobber
#
EXTERN_CLOBBER= ${EXTERN_O} ${EXTERN_LIBA}


######################
# target information #
######################

# man pages
#
MAN1_TARGETS= checknr.1
MAN3_TARGETS=
MAN8_TARGETS=
ALL_MAN_TARGETS= ${MAN1_TARGETS} ${MAN3_TARGETS} ${MAN8_TARGETS}

# libraries
#
LIBA_TARGETS=

# include files
#
H_SRC_TARGETS=

# what to make by all but NOT to removed by clobber (because they are not files)
#
ALL_OTHER_TARGETS= extern_all

# what to make by all and removed by clobber (and thus not ${ALL_OTHER_TARGETS})
#
TARGETS= checknr


###########################################
# all rule - default rule - must be first #
###########################################

all: ${TARGETS} ${ALL_OTHER_TARGETS} Makefile
	@:


######################################################
# List rules that do not create themselves as .PHONY #
######################################################

.PHONY: all configure clean clobber install test \
	extern_include extern_objs extern_liba extern_man extern_all


################
# what to make #
################

checknr: checknr.c
	${CC} ${CFLAGS} checknr.c -o $@


###########################################
# rules for use by higher level Makefiles #
###########################################

extern_include: ${EXTERN_H}
	@:

extern_objs: ${EXTERN_O}
	@:

extern_liba: ${EXTERN_LIBA}
	@:

extern_man: ${EXTERN_MAN}
	@:

extern_all: extern_include extern_objs extern_liba extern_man
	@:

#######################
# internal make rules #
#######################

test: checknr checknr.1
	./checknr -c.Ar.Bd.Bl.Bx.Dd.Dt.Ed.El.Fl.It.Nd.Nm.Op.Os.Pp.Ql.Sh.Sq.Xr checknr.1
	@echo all is well

check_man: test


#######################
# common make actions #
#######################

configure:
	@echo nothing to $@

clean:
	${RM} -f ${ALL_OBJS}
	${RM} -f ${ALL_BUILT_SRC}

clobber: clean
	${RM} -f ${TARGETS}
	${RM} -f ${EXTERN_CLOBBER}
	${RM} -f tags

install: all
#none#	${INSTALL} -v -d -m 0775 ${DEST_LIB}
	${INSTALL} -v -d -m 0775 ${DEST_DIR}
	${INSTALL} -v -d -m 0775 ${MAN1_DIR}
#none#	${INSTALL} -v -d -m 0775 ${MAN3_DIR}
#none#	${INSTALL} -v -d -m 0775 ${MAN8_DIR}
#none#	${INSTALL} -v -d -m 0775 ${DEST_INCLUDE}
	${INSTALL} -v -m 0444 ${MAN1_TARGETS} ${MAN1_DIR}
#none#	${INSTALL} -v -m 0444 ${MAN3_TARGETS} ${MAN3_DIR}
#none#	${INSTALL} -v -m 0444 ${MAN8_TARGETS} ${MAN8_DIR}
#none#	${INSTALL} -v -m 0444 ${LIBA_TARGETS} ${DEST_LIB}
#none#	${INSTALL} -v -m 0444 ${H_SRC_TARGETS} ${DEST_INCLUDE}
	${INSTALL} -v -m 0555 ${TARGETS} ${DEST_DIR}

tags: ${ALL_SRC} ${ALL_BUILT_SRC}
	-${CTAGS} ${ALL_SRC} ${ALL_BUILT_SRC} 2>&1 | \
	     ${GREP} -E -v 'Duplicate entry|Second entry ignored'
