---- MODULE mc ----

(* Le problème des missionnaires et des cannibales *)

EXTENDS Naturals, FiniteSets

CONSTANTS numMiss, numCan

ASSUME numMiss \in Nat /\ numCan \in Nat

VARIABLES
    missG,
    missD,
    canG,
    canD,
    barque

TypeOK == [] (barque \in {"G", "D"})

NombreOK == [](
    /\ missG + missD = numMiss
    /\ canG + canD = numCan
)

pasMiam ==
    /\ missG > 0 => missG >= canG
    /\ missD > 0 => missD >= canD

ToujoursOK == []pasMiam

Solution ==
    [] \neg(missD = numMiss /\ canD = numCan)
-----------------------------------------

(* prédicats sur la barque *)
barqueGD ==
    /\ barque = "G"
    /\ barque' = "D"

barqueDG ==
    /\ barque = "D"
    /\ barque' = "G"

(* prédicats sur les missionnaires *)
missGD1 ==
    /\ missG' = missG - 1
    /\ missD' = missD + 1

missGD2 ==
    /\ missG' = missG - 2
    /\ missD' = missD + 2

missDG1 ==
    /\ missD' = missD - 1
    /\ missG' = missG + 1

missDG2 ==
    /\ missD' = missD - 2
    /\ missG' = missG + 2

(* prédicats sur les cannibales *)
canGD1 ==
    /\ canG' = canG - 1
    /\ canD' = canD + 1

canGD2 ==
    /\ canG' = canG - 2
    /\ canD' = canD + 2

canDG1 ==
    /\ canD' = canD - 1
    /\ canG' = canG + 1

canDG2 ==
    /\ canD' = canD - 2
    /\ canG' = canG + 2

-----------------------------------------
Init ==
    /\ missG = numMiss
    /\ missD = 0
    /\ canG = numCan
    /\ canD = 0
    /\ barque = "G"

(* Bouger 1 missionaire G -> D *)
bougerM_GD ==
    /\ barqueGD
    /\ missG >= 1
    /\ missGD1
    /\ UNCHANGED <<canG,canD>>
    /\ pasMiam'

(* Bouger 2 missionaires G -> D *)
bougerMM_GD ==
    /\ barqueGD
    /\ missG >= 2
    /\ missGD2
    /\ UNCHANGED <<canG,canD>>
    /\ pasMiam'

(* Bouger 1 cannibale G -> D *)
bougerC_GD ==
    /\ barqueGD
    /\ canG >= 1
    /\ canGD1
    /\ UNCHANGED <<missG,missD>>
    /\ pasMiam'

(* Bouger 2 cannibales G -> D *)
bougerCC_GD ==
    /\ barqueGD
    /\ canG >= 2
    /\ canGD2
    /\ UNCHANGED <<missG,missD>>
    /\ pasMiam'

(* Bouger 1 de chaque G -> D *)
bougerMC_GD ==
    /\ barqueGD
    /\ missG >= 1
    /\ canG >= 1
    /\ missGD1
    /\ canGD1
    /\ pasMiam'
----------------------------------

(* Bouger 1 missionaire D -> G *)
bougerM_DG ==
    /\ barqueDG
    /\ missD >= 1
    /\ missDG1
    /\ UNCHANGED <<canG,canD>>
    /\ pasMiam'

(* Bouger 2 missionaires D -> G *)
bougerMM_DG ==
    /\ barqueDG
    /\ missD >= 2
    /\ missDG2
    /\ UNCHANGED <<canG,canD>>
    /\ pasMiam'

(* Bouger 1 cannibale D -> G *)
bougerC_DG ==
    /\ barqueDG
    /\ canD >= 1
    /\ canDG1
    /\ UNCHANGED <<missG,missD>>
    /\ pasMiam'

(* Bouger 2 cannibales D -> G *)
bougerCC_DG ==
    /\ barqueDG
    /\ canD >= 2
    /\ canDG2
    /\ UNCHANGED <<missG,missD>>
    /\ pasMiam'

(* Bouger 1 de chaque D -> G *)
bougerMC_DG ==
    /\ barqueDG
    /\ missD >= 1
    /\ canD >= 1
    /\ missDG1
    /\ canDG1
    /\ pasMiam'

Next ==
    \/ bougerM_GD
    \/ bougerMM_GD
    \/ bougerC_GD
    \/ bougerCC_GD
    \/ bougerMC_GD
    \/ bougerM_DG
    \/ bougerMM_DG
    \/ bougerC_DG
    \/ bougerCC_DG
    \/ bougerMC_DG

Spec == Init /\ [] [ Next ]_<<missG, missD, canG, canD, barque>>

====