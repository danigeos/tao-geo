BEGIN { 
	printf("#Atomatically produced file (using get_results.awk) \n#of results of parametrization.\n")
	printf("#Te\tL\tw0\tvol\n")
	printf("#[km]\t[km]\t[m]\t[km2]\n>\n")
	for(T=10; T<=80; T*=2) { 
		for(l=5; l<=400; l*=sqrt(sqrt(2))) { 
			com = sprintf("echo 0 2800   > le1.CRG"); 	system(com);
			com = sprintf("echo %f 0    >> le1.CRG", -l*1000); system(com);
			com = sprintf("echo %f 1000 >> le1.CRG", -l*1000); system(com);
			com = sprintf("echo 0  1000 >> le1.CRG"); 	system(com);
			com = sprintf("echo 0  0    >> le1.CRG"); 	system(com);
			com = sprintf("tao le -S -T%.2f", T*1000); 
			#print com
			system(com); 
			printf("%.0f\t%.2f\t", T, l); 
			system("awk -f get_volume_loadend.awk le.pfl");
		} 
		printf(">\n")
	} 
}
