set ING;
set FAR;
set OLI;
set NUT;

param costo {ING}; #eur/kg
param nut_min{NUT}; #g
param nut_max{NUT}; #g
param nut_ing{ING, NUT}; #g/100 g
 
var x{ING} >= 0; #g

minimize costo_t:
	sum{i in ING} (x[i] * costo[i]) / 1000;

subject to farina_p:
	sum{i in FAR} x[i] = 150;
	
subject to olio_p:
	sum{i in OLI} x[i] = 15;
	
subject to nutrineti{j in NUT}:
	nut_min[j] <= sum {i in ING} (x[i] * nut_ing[i,j]) / 100 <= nut_max[j]; 
	


	