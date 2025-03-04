---------------- MODULE jeton ----------------
\* Time-stamp: <09 oct 2024 11:55 Philippe Queinnec>

(* Algorithme d'exclusion mutuelle à base de jeton. *)

EXTENDS Naturals, FiniteSets

CONSTANT N

ASSUME N \in Nat /\ N > 1

Processus == 0..N-1

Hungry == "H"
Thinking == "T"
Eating == "E"

VARIABLES
  etat,
  jeton

TypeOK ==
   [] (/\ etat \in [ Processus -> {Hungry,Thinking,Eating} ]
       /\ jeton \in Processus)

\* un processus max a le jeton
ExclMutuelle ==
    [] (\A i,j \in Processus : (etat[i] = Eating /\ etat[j] = Eating) => (i = j))

\* un processus qui demande obtiendra plus tard
VivaciteIndividuelle ==
    \A i \in Processus : (etat[i] = Hungry ~> etat[i] = Eating)

\* si un processus demande, un processus obtiendra plus tard (pas forcément le même)
VivaciteGlobale ==
    (\E i \in Processus : etat[i] = Hungry) ~> (\E j \in Processus : etat[j] = Eating)

JetonVaPartout ==
    \A i \in Processus : [] <> (jeton = i)

Sanity ==
  [] (\A i \in Processus : etat[i] = Eating => jeton = i)

----------------------------------------------------------------

Init ==
 /\ etat = [ i \in Processus |-> Thinking ]
 /\ jeton \in Processus

demander(i) ==
  /\ etat[i] = Thinking
  /\ etat' = [ etat EXCEPT ![i] = Hungry ]
  /\ UNCHANGED jeton

entrer(i) ==
  /\ etat[i] = Hungry
  /\ jeton = i
  /\ etat' = [ etat EXCEPT ![i] = Eating ]
  /\ UNCHANGED jeton

sortir(i) ==
  /\ etat[i] = Eating
  /\ etat' = [ etat EXCEPT ![i] = Thinking ]
  /\ jeton' = (i+1)%N \* ajout pour supprimer SF(bouger(i))
\*   /\ UNCHANGED jeton \* modif pour supprimer SF(bouger(i))

bouger(i) ==
  /\ jeton = i
  /\ etat[i] # Eating
  /\ jeton' = (i+1)%N
  /\ etat[i] /= Hungry \* ajout pour supprimer SF(entrer(i))
  /\ UNCHANGED etat

Next ==
 \E i \in Processus :
    \/ demander(i)
    \/ entrer(i)
    \/ sortir(i)
    \/ bouger(i)

Fairness == \A i \in Processus :
              /\ WF_<<etat,jeton>> (entrer(i))
              /\ WF_<<etat,jeton>> (sortir(i))
              /\ WF_<<etat,jeton>> (bouger(i))

Spec ==
 /\ Init
 /\ [] [ Next ]_<<etat,jeton>>
 /\ Fairness

================
