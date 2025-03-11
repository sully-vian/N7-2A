---------------- MODULE philosophes1 ----------------
(* Philosophes. Version en utilisant l'état des fourchettes. *)

EXTENDS Naturals

CONSTANT N

Philos == 0..N-1

gauche(i) == (i+1)%N       \* philosophe à gauche du philo n°i
droite(i) == (i+N-1)%N     \* philosophe à droite du philo n°i

Hungry == "H"
Thinking == "T"
Eating == "E"

\* état d'une fourchette
Left == "L"
Right == "R"
Table == "T" \* fourchette inutilisée

VARIABLES
    etat         \* i -> Hungry,Thinking,Eating
    forks

TypeOK ==
    /\ [](etat \in [ Philos -> { Hungry, Thinking, Eating } ])
    /\ [](forks \in [ Philos -> {Left, Right, Table} ])

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
    /\ forks = [ i \in Philos |-> Table ]

demander(i) ==
    /\ etat[i] = Thinking
    /\ etat' = [ etat EXCEPT ![i] = Hungry ]
    /\ UNCHANGED forks

prendreG(i) ==
    /\ etat[i] = Hungry
    /\ forks[i] = Table
    /\ forks' = [ forks EXCEPT ![i] = Right ]
    /\ UNCHANGED etat

prendreD(i) ==
    /\ etat[i] = Hungry
    /\ forks[(i+N-1)%N] = Table
    /\ forks' = [ forks EXCEPT ![(i+N-1)%N] = Left ]
    /\ UNCHANGED etat

manger(i) ==
    /\ etat[i] = Hungry
    /\ etat' = [ etat EXCEPT ![i] = Eating ]
    /\ etat[gauche(i)] /= Eating
    /\ etat[droite(i)] /= Eating
    /\ forks[i] = Left
    /\ forks[(i+N-1)%N] = Right
    /\ UNCHANGED forks

penser(i) ==
    /\ etat[i] = Eating
    /\ etat' = [ etat EXCEPT ![i] = Thinking ]
    /\ forks' = [ forks EXCEPT ![i] = Table, ![(i+N-1)%N] = Table ]

Next == \E i \in Philos :
    \/ demander(i)
    \/ prendreG(i)
    \/ prendreD(i)
    \/ manger(i)
    \/ penser(i)

Fairness == \A i \in Philos : TRUE

Spec ==
  /\ Init
  /\ [] [ Next ]_<<etat>>
  /\ Fairness

================================
