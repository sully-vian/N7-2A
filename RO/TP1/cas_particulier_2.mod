###############################  Model ###############################

###############################  Sets  ###############################

set DESTINATIONS;

################### Variables ###################

# trajets[i,j] = 1 si on va de i à j, 0 sinon
var trajets{i in DESTINATIONS, j in DESTINATIONS}, binary;

# rang[i] = position de la destination i
var rang{i in DESTINATIONS}, integer, >=1, <=card(DESTINATIONS);

###################  Constants: Data to load   #########################

param dist{i in DESTINATIONS, j in DESTINATIONS};

################### Constraints ###################

# On ne peut pas aller de i à i
s.t. RespectDiag{i in DESTINATIONS}:
    trajets[i,i] = 0;

# le livreur part exactement une fois de chaque destination
s.t. RespectDepartUnique{i in DESTINATIONS}:
    sum{j in DESTINATIONS} trajets[i,j] = 1;

# le livreur arrive exactement une fois à chaque destination
s.t. RespectArriveeUnique2{j in DESTINATIONS}:
    sum{i in DESTINATIONS} trajets[i,j] = 1;

# le livreur part d'ALPHA
s.t. DepartAlpha:
    rang['ALPHA'] = 1;

# tous les clients sont visités après ALPHA
s.t. RangClients{i in DESTINATIONS: i != 'ALPHA'}:
    rang[i] >= 2;

# pas de boucle
s.t. pasDeboucle {i in DESTINATIONS, j in DESTINATIONS: i != 'ALPHA' && j != 'ALPHA' && i != j}:
    rang[i] - rang[j] + card(DESTINATIONS) * trajets[i,j] <= card(DESTINATIONS) - 1;

###### Objective ######

minimize CoutTotal:
    sum{i in DESTINATIONS, j in DESTINATIONS} dist[i,j] * trajets[i,j];

end;
