#----------------------------- tao makefile -----------------------------
#
#First read and modify options in ./config.mk
#
#Type  'make'  in this directory to compile tao 
#
#tAo has been succesfully compiled with this Makefile in: 
#  macOS 11, macOS 16, linux, 
#Earlier versions were functional for:
#  IBM AIX Version 3.2 for IBM RISC 6000 workstations, Hewlett Packard Envizex. Sun Solaris OS5
#------------------------------------------------------------------------

include config.mk


all:
	@echo; echo; echo Compiling version $(VERSION)
	(cd src; make all)
	@echo; echo; echo Compilation succeeded!
	@(echo "ADD TO YOUR PATH: `pwd`/bin/  AND  `pwd`/script/")
	@(echo "ADD IN .cshrc:    setenv tao_dir `pwd` ")
	@(echo "ADD IN .bashrc:   export tao_dir=`pwd` ")

clean_for_tar:
	(cd src; make clean)
	#rm -f src/*.o lib/libreria.o lib/libreria.a 
	(cd demo; rm -f `find . -name '*[0-9][0-9][2-9].jpg' -print`)


vers: 	clean_for_tar
	echo "CLEANING for packing"
	rm -R -f tmp tao_copy_for_upload
	mkdir tmp tmp/bin
	cp -R -L Makefile config.mk README demo doc include lib script src   tmp
	rm -f tmp/doc/.first_compilation.txt #tmp/lib/sistbanda* version_tmp/lib/surf_proc* version_tmp/lib/thin_sheet* 
	rm -r -f tmp/demo/Andes
	echo "PACKING"
	tar -chf tao.tar tmp
	chmod og-r tao.tar
	gzip -f tao.tar
	touch tmp/bin/touch_something #needed by git add
	mv tmp tao_copy_for_upload
	make upload


upload:
	echo "UPLOADING to github."
	cd tao_copy_for_upload; 
	#For initialization:  
	#git init; 
	#git remote add tao https://github.com/danigeos/tao-geo; 
	#git add .; 
	git commit -a -m$(VERSION)
	git config http.postBuffer 524288000; git config http.maxRequestBuffer 100M; git config core.compression 0; 
	#add --force to pass by the remote version 
	git push -u -f tao master

