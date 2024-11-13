open Peano

type 't expr =
  | Entier : int -> int expr
  | Booleen : bool -> bool expr
  | Plus : int expr * int expr -> int expr
  | Egal : 't expr * 't expr -> bool expr

(* Exercice 4 *)
let rec eval : type t. t expr -> t = function
  | Entier n -> n
  | Booleen b -> b
  | Plus (e1, e2) -> eval e1 + eval e2
  | Egal (e1, e2) -> eval e1 = eval e2
;;

(* Exercice 5 *)
type valeur =
  | Int of int
  | Bool of bool

type code =
  | PushI of int
  | PushB of bool
  | Add
  | Equ
  | Seq of code * code

(* 1 *)
let rec compile : type t. t expr -> code = function
  | Entier n -> PushI n
  | Booleen b -> PushB b
  | Plus (e1, e2) -> Seq (compile e1, Seq (compile e2, Add))
  | Egal (e1, e2) -> Seq (compile e1, Seq (compile e2, Equ))
;;

(* 2 *)
let rec exec : code -> valeur list -> valeur list =
  fun c p ->
  match c, p with
  | PushI n, _ -> Int n :: p
  | PushB b, _ -> Bool b :: p
  | Add, Int n1 :: Int n2 :: t -> Int (n1 + n2) :: t
  | Equ, Int n1 :: Int n2 :: t -> Bool (n1 = n2) :: t
  | Equ, Bool b1 :: Bool b2 :: t -> Bool (b1 = b2) :: t
  | Seq (code1, code2), _ ->
    let p' = exec code1 p in
    exec code2 p'
  | _ -> failwith "Mauvais typage"
;;

(* Exercice 6 *)
type ('stin, 'stout) code' =
  (* besoin de rien en stin, mais place int sur stout *)
  | PushI : int -> ('a, int * 'b) code'
  (* idem pour bool *)
  | PushB : bool -> ('a, bool * 'b) code'
  (* besoin de deux int en entrée et en sort un *)
  | Add : (int * (int * 'next), int * 'next) code'
  (* besoin de deux types identiques en entrée pour un bool en sortie *)
  | Equ : ('a * ('a * 'next), bool * 'next) code'
  (* "loi de Chasles" *)
  | Seq : ('stin, 'stmid) code' * ('stmid, 'stout) code' -> ('stin, 'stout) code'

(* Exercice 7 *)
let rec compile : type stin t. t expr -> (stin, t * stin) code' = function
  | Entier n -> PushI n
  | Booleen b -> PushB b
  | Plus (e1, e2) -> Seq (compile e1, Seq (compile e2, Add))
  | Egal (e1, e2) -> Seq (compile e1, Seq (compile e2, Equ))
;;

let rec exec : type stin stout. (stin, stout) code' -> stin -> stout = function
  | PushI n -> fun st -> n, st
  | PushB b -> fun st -> b, st
  | Add ->
    (* Pas besoin de plus de cas puisque le 2e arg de exec est de type stin donc  *)
    (function
      | x, (y, st) -> x + y, st)
  | Equ ->
    (function
      | x, (y, st) -> x = y, st)
  | Seq (code1, code2) ->
    fun st ->
      let stmid = exec code1 st in
      exec code2 stmid
;;
