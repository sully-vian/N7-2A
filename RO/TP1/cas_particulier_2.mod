###############################  Model ###############################

###############################  Sets  ###############################

set DESTINATIONS;

################### Variables ###################

# trajets[i,j] = 1 si on va de i à j, 0 sinon
var trajets{i in DESTINATIONS, j in DESTINATIONS}, binary;

# rang[i] = position de la destination i
var rang{i in DESTINATIONS}, >=1, <=card(DESTINATIONS);

###################  Constants: Data to load   #########################

param dist{i in DESTINATIONS, j in DESTINATIONS};

################### Constraints ###################

# On ne peut pas aller de i à i
s.t. RespectDiag{i in DESTINATIONS}:
    trajets[i,i] = 0;

# une entrée pour chaque destination
s.t. RespectPassageUnique{i in DESTINATIONS}:
    sum{j in DESTINATIONS} trajets[i,j] = 1;

# une sortie pour chaque destination
s.t. RespectPassageUnique2{j in DESTINATIONS}:
    sum{i in DESTINATIONS} trajets[i,j] = 1;

# partir de ALPHA
s.t. DepartAlpha:
    sum{j in DESTINATIONS} trajets['ALPHA',j] = 1;

# pas de boucle
s.t. pasDeboucle {i in DESTINATIONS, j in DESTINATIONS: i != j}:
    rang[i] - rang[j] + card(DESTINATIONS) * trajets[i,j] <= card(DESTINATIONS) - 1;

###### Objective ######

minimize CoutTotal:
    sum{i in DESTINATIONS, j in DESTINATIONS} dist[i,j] * trajets[i,j];

end;
