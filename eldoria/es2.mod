set INV;
set PERIODI ordered;

param budget;
param TassoInteresse;
param CostoIniziale{INV};

param FlussoCassa{INV,PERIODI};
param FlussoCassaAtt{i in INV, j in PERIODI} :=
	FlussoCassa[i,j]/(1+TassoInteresse)^(ord(j,PERIODI)-1);

var x{INV} binary;

maximize indici_reddita_tot:
	sum{i in INV} sum{j in PERIODI} FlussoCassaAtt[i,j] * x[i];

subject to budget_iniziale:
	sum{i in INV} CostoIniziale[i] * x[i] <= budget;

subject to agric_amb:
	x["Agricola"] <= x["Ambientale"];

subject to dif_eco_all:
	x["Difesa"] + x["Economico"] + x["Alleanze"] >= 1;

