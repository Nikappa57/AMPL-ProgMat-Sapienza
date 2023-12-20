set NANI;
set ELFI;
set GUERR;
set MAG;
set PERSONAGGI := NANI union ELFI union GUERR union MAG;
set ABILITA;

param costo{PERSONAGGI};

param caratt{PERSONAGGI, ABILITA};
param pot_max{PERSONAGGI};

var x{PERSONAGGI} binary;
var y1{PERSONAGGI, ABILITA} binary;
var y3{PERSONAGGI, ABILITA} binary;
var y2{PERSONAGGI, ABILITA} binary;

minimize costo_totale:
	sum{p in PERSONAGGI} (costo[p]*x[p] 
		+ sum{a in ABILITA} (y1[p, a] * 25 + y2[p, a] * 95 + y3[p, a] * 160));

subject to forza_totale:
	sum{p in PERSONAGGI} (x[p] * caratt[p, "forza"] + y1[p, "forza"] + 2*y2[p, "forza"] + 3*y3[p, "forza"])  >= 37;

subject to resistenza_totale:
	sum{p in PERSONAGGI}  (x[p] * caratt[p, "resitenza"] + y1[p, "resitenza"] + 2*y2[p, "resitenza"] + 3*y3[p, "resitenza"]) >= 45;

subject to magia_totale:
	sum{p in PERSONAGGI} (x[p] * caratt[p, "magia"] + y1[p, "magia"] + 2*y2[p, "magia"] + 3*y3[p, "magia"]) >= 10;

subject to astuzia_totale:
	sum{p in PERSONAGGI} (x[p] * caratt[p, "astuzia"] + y1[p, "astuzia"] + 2*y2[p, "astuzia"] + 3*y3[p, "astuzia"]) >= 30;

subject to codardia_totale:
	sum{p in PERSONAGGI} (x[p] * caratt[p, "codardia"] - y1[p, "codardia"] - 2*y2[p, "codardia"] - 3*y3[p, "codardia"]) <= 30;

subject to corruzione_totale:	
	sum{p in PERSONAGGI} (x[p] * caratt[p, "corruzione"] - y1[p, "corruzione"] - 2*y2[p, "corruzione"] - 3*y3[p, "corruzione"]) <= 33;

subject to nani_elfi:
	sum{p in NANI} x[p] = sum{p in ELFI} x[p];

subject to guer_mag:
	sum{p in GUERR} x[p] <= sum{p in MAG} x[p];

subject to pot_max_limit {p in PERSONAGGI}:
	sum {a in ABILITA} (y1[p, a] + y2[p, a] + y3[p, a]) <= pot_max[p];

subject to attiva{p in PERSONAGGI, a in ABILITA}:
	y1[p, a] + y2[p, a] + y3[p, a] <= x[p];
