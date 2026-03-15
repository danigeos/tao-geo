BEGIN {
	#print "Te=", Te, "wave_length=", wl, "t/tau=", tdivtau, "densasthen=", densasthen, "horz_force=", horz_force
	rhomg = densasthen*9.81; 
	#OJO ERROR: esta D solo vale para el caso elastico!!
	D=Te*Te*Te*7e10/12/(1-.5*.5); 
	k=2*3.1415927/wl;
	k2=k*k; k4=k2*k2; 
	Ce = 1/(1+D/rhomg*k4-horz_force/rhomg*k2);
	Cv = 1-(1-Ce)*exp(-Ce*tdivtau);
	print "\t", Ce, "\t", Cv; 
}
