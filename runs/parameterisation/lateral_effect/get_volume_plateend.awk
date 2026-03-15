#This awk reads a tao *.pfl file and sumes deflection.
#This awk is called by get_results.awk
BEGIN {
	xl=0; np=0;
}

{
	if (NR>3 && $1>=xl && signal==0) {
		signal=1;
		printf("%.1f\t", -$2); 
	} 
	if (NR>3 && $1>=xl && $2<0) {
		volum+=$2; 
		xr=$1; 
		np++;
	}
} 

END {
	volum *= -(xr-xl)/(np-1)/1000;
	print volum;
}
