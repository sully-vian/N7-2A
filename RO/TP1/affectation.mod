###############################  Model ###############################

###############################  Sets  ###############################

set PERSONNES;

set TACHES;

################### Variables ###################

var A{i in PERSONNES, j in TACHES}, binary;

###################  Constants: Data to load   #########################

param preference{i in PERSONNES, j in TACHES};

################### Constraints ###################

s.t. RespecteUniteTache{i in PERSONNES}:
    sum{j in TACHES} A[i,j] = 1;

s.t. RespecteUnitePersonne{j in TACHES}:
    sum{i in PERSONNES} A[i,j] = 1;

###### Objective ######

maximize BonheurTotal:
    sum{i in PERSONNES, j in TACHES} A[i,j] * preference[i,j];

end;
