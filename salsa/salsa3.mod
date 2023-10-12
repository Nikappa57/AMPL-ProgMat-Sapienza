set PROD;
set REP;
set INGR;
set QUAL;

param prezzo{PROD}; 			# eur/kg
param costo_base{PROD};			# eur/kg
param costo_ingr{INGR};			# eur/kg
param qual_ingr{QUAL, INGR};	# %
param qual_min{QUAL, PROD}; 	# %
param qual_max{QUAL, PROD}; 	# %
param tempo_prod{REP, PROD}; 	# min
param tempo_max{REP};		 	# min
param prod_min{PROD}; 
param prod_max{PROD};

var x{PROD, INGR} >= 0; # kg
var produz{PROD} >= 0;

maximize profitto:
	sum {i in PROD} (prezzo[i] * produz[i] - costo_base[i] * produz[i] 
		- sum{k in INGR} x[i, k] * costo_ingr[k]);

subject to produzione_x {i in PROD}:
	sum {k in INGR} x[i, k] = produz[i];

subject to ketchup_max:
	sum {k in INGR} x['ket', k] <= 0.4 * sum{i in PROD, k in INGR} x[i, k];

subject to produzione_richiesta {i in PROD}:
	prod_min[i] <= produz[i] <= prod_max[i];

subject to cosumo_reparti {j in REP}:
 	sum{i in PROD} produz[i] * tempo_prod[j, i] <= tempo_max[j];

subject to qualita_min {z in QUAL, i in PROD}:
	sum{k in INGR} x[i, k] * qual_ingr[z, k] 
		>= qual_min[z, i] * sum{w in INGR} x[i, w];

subject to qualita_max {i in PROD, z in QUAL}:
	sum{k in INGR} x[i, k] * qual_ingr[z, k] 
		<= qual_max[z, i] * sum{w in INGR} x[i, w];
	
	
	