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
type ('stin, 'stout) code =
  | Nil : (nil, nil) code
  | Cons :
      ('stin_ * 'stout_) * ('stin, 'stout) code
      -> ('stin_ * 'stout_, 'stin * 'stout) code

let compile : 't expr -> ('stin, 'stout) code = function
  | Entier n -> PushI n
  | _ -> failwith "aaa"
;;
