set DIREZIONI;
set FABBRICHE;
set BASTONI;

param distanza{DIREZIONI,FABBRICHE};
param distMin;

var x{BASTONI, DIREZIONI} >= 0;

minimize dist_max:
	sum{j in FABBRICHE}(
		max{i in BASTONI} (sqrt((
			x[i, 'NORD'] - distanza['NORD', j])^2 
			+ (x[i, 'EST'] - distanza['EST', j])^2))
	);

subject to distanza_bastoni:
	((x['B1', 'NORD']-x['B2', 'NORD'])^2+(x['B1', 'EST']-x['B2', 'EST'])^2) >= distMin^2;


