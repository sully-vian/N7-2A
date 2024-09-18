(*  Exercice à rendre **)
(* pgcd : int -> int -> int *)
(* renvoie le pgcd de deux entiers strictement positifs *)
(* a : le premier entier *)
(* b : le second entier *)
(* renvoie le pgcd de a et b *)
(* précondition : (a > 0) /\ (b > 0) *)
let rec pgcd a b =
  if (a = b) then
    a
  else if (a > b) then
    pgcd (a - b) b
  else
    pgcd a (b - a)

let%test _ = (pgcd 8 8) = 8
let%test _ = (pgcd 24 36) = 12
let%test _ = (pgcd 120 13) = 1

(* pgcd_bis : int -> int -> int *)
(* renvoie le pgcd de deux entiers non nuls *)
(* a : le premier entier *)
(* b : le second entier *)
(* renvoie le pgcd de a et b *)
(* précondition : (a != 0) /\ (b != 0) *)
let pgcd_bis a b =
  let a_abs = if (a > 0) then a else -a in
  let b_abs = if (b > 0) then b else -b in
  pgcd a_abs b_abs

let%test _ = (pgcd_bis (-10) (-10)) = 10
let%test _ = (pgcd_bis 11 (-20)) = 1
let%test _ = (pgcd_bis (-12) (-16)) = 4