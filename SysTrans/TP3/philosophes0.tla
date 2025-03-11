---------------- MODULE philosophes0 ----------------
(* Philosophes. Version en utilisant l'état des voisins. *)

EXTENDS Naturals

CONSTANT N

Philos == 0..N-1

gauche(i) == (i+1)%N       \* philosophe à gauche du philo n°i
droite(i) == (i+N-1)%N     \* philosophe à droite du philo n°i

Hungry == "H"
Thinking == "T"
Eating == "E"

VARIABLES
    etat         \* i -> Hungry,Thinking,Eating

TypeOK == [](etat \in [ Philos -> { Hungry, Thinking, Eating }])

\* exclusion
ExclMutuelle == [] (\A i \in Philos : (etat[i] = Eating) =>
    (etat[gauche(i)] /= Eating /\ etat[droite(i)] /= Eating))

\* vivacité individuelle
VivaciteIndividuelle ==
    \A i \in Philos :  etat[i] = Hungry ~> etat[i] = Eating

\* vivacité globale
VivaciteGlobale ==
    (\E i \in Philos : etat[i] = Hungry) ~>
    (\E j \in Philos : etat[j] = Eating)

----------------------------------------------------------------

Init ==
    /\ etat = [ i \in Philos |-> Thinking ]

demander(i) ==
    /\ etat[i] = Thinking
    /\ etat' = [ etat EXCEPT ![i] = Hungry ]

manger(i) ==
    /\ etat[i] = Hungry
    /\ etat' = [ etat EXCEPT ![i] = Eating ]
    /\ etat[gauche(i)] /= Eating
    /\ etat[droite(i)] /= Eating

penser(i) ==
    /\ etat[i] = Eating
    /\ etat' = [ etat EXCEPT ![i] = Thinking ]

Next ==
  \E i \in Philos : \/ demander(i)
                    \/ manger(i)
                    \/ penser(i)

Fairness == \A i \in Philos :
    /\ SF_<<etat>> (manger(i))
    /\ SF_<<etat>> (penser(i))
    /\ SF_<<etat>> (demander(i))

Spec ==
  /\ Init
  /\ [] [ Next ]_<<etat>>
  /\ Fairness

================================
