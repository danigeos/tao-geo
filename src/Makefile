#----------------------------- tao makefile -----------------------------
#
#Read and modify options in ../config.mk
#
#Type  'make'  in this directory to compile.
#
#------------------------------------------------------------------------

include ../config.mk


#------------------------------------------------------------------------
#You should not modify these directories
tao_DIR = \"`cd ..; pwd`\"
HOME_DIR = `cd; pwd`
OS 	= `../script/match_OS`
ARCH 	= `../script/match_arch`
BIN	= ../bin
OBJ	= .
LIB	= ../lib
INCL	= ../include 

all:	clean tao invertfile taofit 

backup:
	cp -f	tao*	$(BACKUPS)

clean:
	rm -f $(OBJ)/*.o $(LIB)/*.o $(LIB)/*.a $(BIN)/.dSYM 
	
TAO_OBJS = tao.o taosp.o globals.o

tao :	$(TAO_OBJS) libreria.o notify
	$(CC)  $(TAO_OBJS) $(LIB)/libreria.o $(OPTS) $(LIBS) -o $(BIN)/tao 
	chmod a+x $(BIN)/tao


tao.o : tao.c taolib.c taosp.c taoio.c
	@echo; echo tao HOME DIRECTORY: $(tao_DIR);  echo ARCH=$(ARCH);  
	@echo OP. SYSTEM=$(OS);  echo User home: $(HOME_DIR); 
	@echo You are currently $(shell whoami)	using the shell $(SHELL) ; echo
	$(CC) $(OPTS) -c -o $(OBJ)/tao.o -DVERSION=\"$(VERSION)\" -DTAODIR=$(tao_DIR) -I$(INCL) tao.c
	if [ -f /usr/bin/ctags ]; then \
		ctags *.c ../lib/libreria.c ../include/*.h;\
		mv -f tags tao.tags; echo tags file produced.;\
	fi

taosp.o : taosp.c
	$(CC) -c -o $(OBJ)/taosp.o $(OPTS) -I$(INCL) taosp.c

globals.o : globals.c
	$(CC) -c -o $(OBJ)/globals.o $(OPTS) -I$(INCL) globals.c

call_taosp.o : call_taosp.c
	$(CC) -c -o call_taosp.o $(OPTS) -I$(INCL) call_taosp.c

libreria.o :
	cd $(LIB) ;  make libreria.o


invertfile: 
	$(CC) invertfile.c $(OPTS) $(LIBS) -I$(INCL) -o $(BIN)/invertfile
	chmod a+x $(BIN)/invertfile


taoconv : 
	$(CC) taoconv.c $(OPTS) $(LIBS) -I$(INCL) -o $(BIN)/taoconv
	chmod a+x $(BIN)/taoconv


taofit : libreria.o globals.o
	$(CC) taofit.c $(OPTS) globals.o $(LIB)/libreria.o  -lc -lm -I$(INCL) -o $(BIN)/taofit
	chmod a+x $(BIN)/taofit

notify :
	@if [ -f ../doc/.first_compilation.txt ]; \
	then echo ; else echo First compilation of tAo in `hostname` by `whoami`>../doc/.first_compilation.txt; pwd>>../doc/.first_compilation.txt; \
		date>>../doc/.first_compilation.txt ; echo>> ../doc/.first_compilation.txt; finger `whoami` >> ../doc/.first_compilation.txt; mail danielgc@ija.csic.es<../doc/.first_compilation.txt; \
	fi
