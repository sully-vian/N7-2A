---- MODULE fact ----
EXTENDS Naturals

CONSTANT N
ASSUME N \in Nat /\ N >= 1
VARIABLES  res, x

Init == /\ res = 1
        /\ x = [i \in 1..N |-> TRUE ]

OneMult(n) == /\ x[n]
              /\ x' = [x EXCEPT ![n] = FALSE]
              /\ res' = res * n

Next == \E n \in 1..N: OneMult(n)

Spec == Init /\ [][Next]_<<res, x>>
====