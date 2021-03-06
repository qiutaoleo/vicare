## Process this file with automake to produce Makefile.in

AM_CFLAGS = -Wall
EXTRA_DIST		= last-revision.h vicare-platform.h.in

SRCS	= \
	cpu_has_sse2.S			\
	ikarus-collect.c		\
	ikarus-enter.S			\
	ikarus-exec.c			\
	ikarus-fasl.c			\
	ikarus-ffi.c			\
	ikarus-flonums.c		\
	ikarus-getaddrinfo.c		\
	ikarus-io.c			\
	ikarus-main.c			\
	ikarus-numerics.c		\
	ikarus-objects.c		\
	ikarus-pointers.c		\
	ikarus-posix.c			\
	ikarus-print.c			\
	ikarus-runtime.c		\
	ikarus-symbol-table.c		\
	ikarus-verify-integrity.c	\
	ikarus-weak-pairs.c		\
	ikarus-winmmap.c		\
	ikarus-glibc.c			\
	ikarus-linux.c			\
	ikarus-readline.c		\
	ikarus-debugging.c		\
	last-revision.h			\
	internals.h

include_HEADERS		= vicare.h vicare-platform.h

MAINTAINERCLEANFILES	= last-revision.h

$(srcdir)/last-revision.h:
	echo '#define LAST_REVISION "no-branch/no-commit"' >$@

ikarus-main.$(OBJEXT) : $(srcdir)/last-revision.h

bin_PROGRAMS		= vicare
vicare_SOURCES		= $(SRCS) ikarus.c

# List of flags to link libraries with the "vicare" executable.
vicare_LDADD		=

# Add Libiconv if requested by the configuration script.
if WANT_LIBICONV
vicare_LDADD		+= @LTLIBICONV@
endif

## --------------------------------------------------------------------

# List of  library specifications:  tell GNU  Automake to  build these
# libraries, too.
lib_LTLIBRARIES			=

# Build   the  Vicare/CRE2   shared  library   if  requested   by  the
# configuration script.
if WANT_CRE2
lib_LTLIBRARIES			+= libvicarecre2.la
libvicarecre2_la_LDFLAGS	= -version-info 0:0:0
libvicarecre2_la_SOURCES	= ikarus-cre2.c
libvicarecre2_la_LIBADD		= @CRE2_LIBS@
endif

## --------------------------------------------------------------------

nodist_vicare_SOURCES = bootfileloc.h
BUILT_SOURCES = bootfileloc.h

bootfileloc.h: Makefile
	echo '#define BOOTFILE "$(pkglibdir)/vicare.boot"' >$@
	echo '#define EXEFILE "$(bindir)/vicare"' >>$@

CLEANFILES = bootfileloc.h

### end of file
