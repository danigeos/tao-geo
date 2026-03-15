#This awk reads a tao *.pfl file and sumes deflection.
#This awk is called by get_results.awk
BEGIN {
	xl=0; np=0;
}

{
	if ($1==0) {
		printf("%.1f\t", -$2); 
	} 
	if (NR>4 && $2<0) {
		volum+=$2; 
		xr=$1; 
		np++;
	}
} 

END {
	volum *= -(xr-xl)/(np-1)/1000;
	print volum;
}
