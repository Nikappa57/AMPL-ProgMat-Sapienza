set RENNE;

param pi;
param l;
param h;

var x{RENNE} >= 0, <= l;
var y{RENNE} >= 0, <= h;
var r{RENNE} >= 0;

maximize SommaAree:
	sum{i in RENNE} pi * (r[i]^2);

subject to max_area:
	sum{i in RENNE} pi * (r[i]^2) <= l * h;

subject to Distanza{i in RENNE, j in RENNE: i != j}:
    (x[i] - x[j])^2 + (y[i] - y[j])^2 >= (20 + r[i] + r[j])^2;

subject to PosizioneX{i in RENNE}:
    x[i] + r[i] <= l;

subject to PosizioneY{i in RENNE}:
    y[i] + r[i] <= h;

subject to Posizione1X{i in RENNE}:
    x[i] - r[i] >= 0;

subject to Posizione1Y{i in RENNE}:
    y[i] - r[i] >= 0;

subject to RTod: r['Tod'] >= 60;
subject to RJimmy: r['Jimmy'] >= 70;
subject to RRuud: r['Ruud'] >= 90;
subject to RFred: r['Fred'] >= 60;
subject to RCharlie: r['Charlie'] >= 55;