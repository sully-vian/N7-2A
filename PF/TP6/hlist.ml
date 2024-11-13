open Peano

(* Exercice 3 *)
(* 1 *)
type 'p hlist =
  | Nil : nil hlist
  | Cons : 'a * 'p hlist -> ('a * 'p) hlist

let exemple = Cons ('a', Cons (true, Cons (1, Nil)))

(* 2 *)
let tail : ('a * 'p) hlist -> 'p hlist = fun (Cons (_, t)) -> t

(* 3 *)
let add : (int * (int * 'p)) hlist -> (int * 'p) hlist =
  fun (Cons (n1, Cons (n2, t))) -> Cons (n1 + n2, t)
;;
