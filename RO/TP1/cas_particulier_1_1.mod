###############################  Model ###############################

###############################  Sets  ###############################

set FLUIDES;

set DEMANDES;

set MAGASINS;

################### Variables ###################

var vol{f in FLUIDES, m in MAGASINS, d in DEMANDES}, >= 0;

###################  Constants: Data to load   #########################

param TabA{d in DEMANDES, f in FLUIDES};

param TabB{m in MAGASINS, f in FLUIDES};

param TabC{m in MAGASINS, f in FLUIDES};

################### Constraints ###################

s.t. RespectA{d in DEMANDES, f in FLUIDES}:
    sum{m in MAGASINS} vol[f,m,d] = TabA[d,f];

s.t. RespectB{m in MAGASINS, f in FLUIDES}:
    sum{d in DEMANDES} vol[f,m,d] <= TabB[m,f];

###### Objective ######

minimize CoutTotal:
    sum{f in FLUIDES, d in DEMANDES, m in MAGASINS} vol[f,m,d] * TabC[m,f];

end;
