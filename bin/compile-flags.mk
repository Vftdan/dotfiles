#! /usr/bin/env -S make -f

compile_flags_mk__flags = ${CFLAGS} ${INCPATH}
ifeq ($(compile_flags_mk__language), c++)
	compile_flags_mk__flags = -xc++ ${CXXFLAGS} ${INCPATH}
endif
ifdef makefile
	compile_flags_mk__dep_makefile := ${makefile}
	undefine makefile
endif
ifndef compile_flags_mk__dep_makefile
	compile_flags_mk__dep_makefile := Makefile
endif

compile_flags.txt: ${compile_flags_mk__dep_makefile}
	for i in ${compile_flags_mk__flags}; do printf "%s\n" "$$i"; done > compile_flags.txt

c++:
	$(MAKE) -f $(MAKEFILE_LIST) $(MFLAGS) compile_flags_mk__language=c++ compile_flags_mk__dep_makefile=${compile_flags_mk__dep_makefile} compile_flags.txt

.PHONY: c++

include ${compile_flags_mk__dep_makefile}
