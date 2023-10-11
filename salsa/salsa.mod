set PROD;
set REP;

param prezzo{PROD}; 	# eur
param costo{PROD};		# eur
param prod_min{PROD}; 	
param prod_max{PROD};
param tempo_prod{REP, PROD}; # min
param tempo_max{REP};			# min

var x{PROD} >= 0;

maximize profitto:
	sum {i in PROD} x[i] * (prezzo[i] - costo[i]);
	
subject to ketchup_max:
	x['ket'] <= 0.4 * sum{i in PROD} x[i];
	
subject to produzione_richiesta {i in PROD}:
	prod_min[i] <= x[i] <= prod_max[i];
	
subject to cosumo_reparti {j in REP}:
	sum{i in PROD} x[i] * tempo_prod[j, i] <= tempo_max[j];

	