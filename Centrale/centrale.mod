set GENERATORI;
set PERIODI;

param costo_attivazione{GENERATORI, PERIODI};
param costo_per_mwatt{GENERATORI};
param capacita_max{GENERATORI};

var produzione{i in GENERATORI, j in PERIODI} >= 0, <= capacita_max[i];
var y{GENERATORI, PERIODI} binary, >= 0;

minimize costo:
	sum {i in GENERATORI, j in PERIODI} 
		(costo_per_mwatt[i] * produzione[i, j]
		+ costo_attivazione[i, j] * y[i, j]);

subject to minimo_giorno:
	sum {i in GENERATORI} produzione[i, "giorno"] >= 4000;
	
subject to minimo_notte:
	sum {i in GENERATORI} produzione[i, "notte"] >= 2800;
	
subject to attiva {i in GENERATORI, j in PERIODI}:
	produzione[i, j] <= capacita_max[i] * y[i, j];
