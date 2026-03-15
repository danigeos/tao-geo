BEGIN {
	OFS="\t"
	ORS=""
	printf "# step\tZn  \tbeta \tTe   \tH. Shoulder\n"
	for (step=4; step<=300; step*=2){
		for (Zn=10; Zn<=70; Zn+=10){
			for (beta=sqrt(2); beta<=6; beta*=sqrt(2)){
				print "> " Zn "\n"
				for (Te=1; Te<=70; Te*=2){
					rho_load=-dens_load_rift(beta,Zn)
					S = -(1-1/beta)*Zn*1000
					printf("-999\t%6.1f\n%8.1f\t%6.1f\n%8.1f\t0", rho_load, 200e3, S, 200e3+step*1000) > "rift0.CRG"
					close ("rift0.CRG")
					comando = sprintf("tao rift -V -S -T%.2f > rift.tao.output", Te*1000)
					system(comando)
					close ("rift.tao.output")
					printf("%5.1f\t%5.1f\t%6.1f\t%5.2f", step, Zn, beta, Te)
					#printf("\t%6.1f\t%5.2f\t", S, rho_load)
					comando = sprintf("awk '{if ($1==\"height\" && $2==\"max.\") {ORS=\"\"; print \"\\t   \" $5 } }' rift.tao.output ")
					system(comando) 
					print "\n"
				}
			}
		}
	}
}




function dens_load_rift (beta,Zn) {
  #Calcula el incremento de carga debido al Stretching y devuelve la 
  #densidad equivalente de la carga de altura s.
	Zn = Zn*1000	#Necking Depth
	rho_c = 2800
	rho_m = 3330
	rho_w = 1030
	alfa = 0.0000328
	T = 1333
	a = 120000
	hc = 30000
	k = 1-1/beta
	S = k*Zn
	load_diff =   -rho_c*hc*k - rho_m*(a-hc)*k 
	load_diff +=  rho_m*alfa*T/2/a * ( (a*a-hc*hc)*(1-1/(beta*beta)) - 2*S/beta*(a-hc) )
	load_diff +=  S*(rho_w-rho_m*(1-alfa*T)) + rho_m*a*(1-alfa*T)*k
	return (load_diff/S)
}