set FORNITORI;
set REPARTI;


param prezzo{FORNITORI};  					#100 kg
param q_min{FORNITORI};  				#100 kg
param q_max{FORNITORI}; 				#100 kg
param resa{FORNITORI};      				#litri per 100 kg
param acidita{FORNITORI};  					#percentuale 
param ore_max_reparto{REPARTI};				#ore massime di un reparto
param temp_lavorazione{FORNITORI,REPARTI};
param min_quant;							#litri
param max_acidita; 							#percentuale 

var x{FORNITORI} >= 0;

minimize costo:
	sum{i in FORNITORI} x[i] * prezzo[i];

subject to acidita_max:
	sum {i in FORNITORI} x[i] * acidita[i] * resa[i] <= max_acidita * sum{i in FORNITORI}x[i] * resa[i];

subject to produzione_min:
	sum{i in FORNITORI} x[i] * resa[i] = min_quant;

subject to max_ore {j in REPARTI}:
	sum{i in FORNITORI} x[i] * temp_lavorazione[i,j] <= ore_max_reparto[j];

 subject to bound_quantita {i in FORNITORI}:
	q_min[i] <= x[i] <= q_max[i];
