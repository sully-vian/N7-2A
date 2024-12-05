###############################  Model ###############################

###############################  Sets  ###############################

set DESTINATIONS;

################### Variables ###################

var trajets{i in DESTINATIONS, j in DESTINATIONS}, binary;

###################  Constants: Data to load   #########################

param dist{i in DESTINATIONS, j in DESTINATIONS};

################### Constraints ###################

s.t. RespectDiag{i in DESTINATIONS}:
    trajets[i,i] = 0;

s.t. RespectPassageUnique{i in DESTINATIONS}:
    sum{j in DESTINATIONS} trajets[i,j] = 1;


s.t. RespectPassageUnique2{j in DESTINATIONS}:
    sum{i in DESTINATIONS} trajets[i,j] = 1;

###### Objective ######

minimize CoutTotal:
    sum{i in DESTINATIONS, j in DESTINATIONS} dist[i,j] * trajets[i,j];

end;
