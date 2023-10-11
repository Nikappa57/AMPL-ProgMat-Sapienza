set att;
set gesti;

param contrib{gesti, att}; # J/min
param lav_min{gesti}; # J
param temp_min; # min

var x{att} >= temp_min; # tempo in min

minimize tempo_totale:
	sum{i in att} x[i];

subject to lavoro_minimo{j in gesti}:
	sum{i in att}contrib[j, i] * x[i] >= lav_min[j];
	
subject to corsa_min:
	x['corsa'] >= 0.15 * sum{i in att} x[i];
	


