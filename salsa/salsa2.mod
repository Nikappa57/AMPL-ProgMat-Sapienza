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
param tempo_max{REP};			# min

var x{PROD, INGR} >= 0; # kg

maximize profitto:
	sum {i in PROD} x[i] * (prezzo[i] - costo[i]);
	
subject to ketchup_max:
	x['ket'] <= 0.4 * sum{i in PROD} x[i];
	
subject to produzione_richiesta {i in PROD}:
	prod_min[i] <= x[i] <= prod_max[i];
	
subject to cosumo_reparti {j in REP}:
	sum{i in PROD} x[i] * tempo_prod[j, i] <= tempo_max[j];

	