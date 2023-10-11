set PROD;
set REP;

param prezzo{PROD}; 	# eur
param costo{PROD};		# eur
param prod_min{PROD}; 	
param prod_max{PROD};
param tempo_prod{REP, PROD}; # min
param tempo_max{REP};			# min

var x{PROD} >= 0;