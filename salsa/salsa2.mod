set PROD;
set REP;
set INGR;
set QUAL;

param prezzo{PROD}; 	# eur/kg
param costo_base{PROD};		# eur/kg
param produz{PROD};		# kg
param costo_ingr{INGR};	# eur/kg
param qual_ingr{QUAL, INGR}; # %
param qual_min{QUAL, PROD}; # %
param qual_max{QUAL, PROD}; # %
param tempo_prod{REP, PROD}; # min
param tempo_max{REP};		 # min

var x{PROD, INGR} >= 0; # kg

maximize profitto:
	sum {i in PROD, k in INGR} x[i, k] * (prezzo[i] - costo_base[i] - costo_ingr[k]);
	
subject to ketchup_max:
	sum {k in INGR} x['ket', k] <= 0.4 * sum{i in PROD, k in INGR} x[i, k];
	
subject to produzione_richiesta {i in PROD}:
	sum {k in INGR} x[i,k] = produz[i];
	
subject to cosumo_reparti {j in REP}:
	sum{i in PROD, k in INGR} x[i, k] * tempo_prod[j, i] <= tempo_max[j];

subject to qualita_min{i in PROD, z in QUAL}:
	sum{k in INGR} x[i, k] * qual_ingr[z, k] 
		>= qual_min[k, i] * sum{y in PROD, w in INGR} x[y, w];

subject to qualita_max{i in PROD, z in QUAL}:
	sum{k in INGR} x[i, k] * qual_ingr[z, k] 
		<= qual_max[k, i] * sum{y in PROD, w in INGR} x[y, w];
	
	
	