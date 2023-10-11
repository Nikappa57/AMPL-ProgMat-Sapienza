# Produzione

set RISORSE;

param costi{RISORSE};
param prof{RISORSE};

var x{RISORSE} >= 0;

maximize profitto:
	sum{i in RISORSE} x[i] * prof[i];
	
	
minimize costi:
	sum {i in RISORSE} x[i] * costi[i];


## Con reparti Concorrenti	

set RISORSE;
set REPARTI;

param costi{RISORSE, REPARTI};
param prof{RISORSE};
param disp_max{REPARTI};
param disp_min{REPARTI};

var x{RISORSE} >= 0;

maximize profitto:
	sum{i in RISORSE} x[i] * prof[i];

minimize costi:
	sum {i in RISORSE} x[i] * costi[i];

subject to limiti {j in REPARTO}:
	disp_min[j] <= sum{i in RISORSE} x[i] * costi[i] <= disp_max[j];
	
## Con reparti risorse Alternavite	

set RISORSE;
set REPARTI;

param costi{RISORSE, REPARTI};
param prof{RISORSE};
param disp_max{REPARTI};
param disp_min{REPARTI};

var x{RISORSE, REPARTI} >= 0;

maximize profitto:
	sum{i in RISORSE, j in REPARTI} x[i, j] * prof[i];

minimize costi:
	sum {i in RISORSE, j in REPARTI} x[i, j] * costi[i];

subject to limiti {j in REPARTO}:
	disp_min[j] <= sum{i in RISORSE} x[i][j] * costi[i] <= disp_max[j];
	

# MISCELA
set PRODOTTI;
set COMPONENTI;


param contentuo{PRODOTTI, COMPONENTI};
param comp_min{COMPONENTI};
param comp_max{COMPONENTI};
param costi{COMPONENTI}; # param prezzo{PRODOTTI};

...

var x{PRODOTTI} >= 0;

subject to limiti {j in COMPONENTI}:
	comp_min[j] <= sum{i in PRODOTTI} x[i] * contentuo[i, j] <= comp_max[j];


