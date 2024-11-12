open Peano

type 'a list =
  | Nil
  | Cons of 'a * 'a list

(* Exercice 1 *)
(* 1 *)
type ('a, 'n) nlist =
  | Nil : ('a, zero) nlist
  | Cons : 'a * ('a, 'n) nlist -> ('a, 'n succ) nlist

(* 2 *)
let rec map : type n. ('a -> 'b) -> ('a, n) nlist -> ('b, n) nlist =
 fun f l ->
  match l with
  | Nil -> Nil
  | Cons (h, t) -> Cons (f h, map f t)
;;

(* 3 *)
let rec snoc : type n. 'a -> ('a, n) nlist -> ('a, n succ) nlist =
 fun e l ->
  match l with
  | Nil -> Cons (e, Nil)
  | Cons (h, t) -> Cons (h, snoc e t)
;;

(* 4 *)
let tail : ('a, 'n succ) nlist -> ('a, 'n) nlist = fun (Cons (_, t)) -> t

(* 5 *)
let rec rev : type n. ('a, n) nlist -> ('a, n) nlist =
 fun l ->
  match l with
  | Nil -> Nil
  | Cons (h, t) -> snoc h (rev t)
;;

(* Ne marche pas *)
(* let rev : type n. ('a, n) nlist -> ('a, n) nlist =
 fun l ->
  let rec aux : type n. ('a, n) nlist -> ('a, n) nlist -> ('a, n) nlist =
   fun l acc ->
    match l with
    | Nil -> acc
    | Cons (h, t) -> aux t (Cons (h, acc))
  in
  aux l Nil
;; *)

(* Exercice 2 *)
let rec insert : type n. 'a -> ('a, n) nlist -> ('a, n succ) nlist =
 fun x l ->
  match l with
  | Nil -> Cons (x, Nil)
  | Cons (h, t) -> if h < x then Cons (h, insert x t) else Cons (x, l)
;;

let rec insertion_sort : type n. ('a, n) nlist -> ('a, n) nlist =
 fun l ->
  match l with
  | Nil -> Nil
  | Cons (h, t) -> insert h (insertion_sort t)
;;
