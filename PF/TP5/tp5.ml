(* Evaluation des expressions simples *)

(* Module abstrayant les expressions *)
module type ExprSimple = sig
  type t

  val const : int -> t
  val plus : t -> t -> t
  val mult : t -> t -> t
end

(* Module réalisant l'évaluation d'une expression *)
module EvalSimple : ExprSimple with type t = int = struct
  type t = int

  let const c = c
  let plus e1 e2 = e1 + e2
  let mult e1 e2 = e1 * e2
end

(* Solution 1 pour tester *)
(* A l'aide de foncteur *)

(* Définition des expressions *)
module ExemplesSimples (E : ExprSimple) = struct
  let exemple1 = E.(plus (const 1) (mult (const 2) (const 3)))
  let exemple2 = E.(mult (plus (const 5) (const 2)) (mult (const 2) (const 3)))
end

(* Module d'évaluation des exemples *)
module EvalExemples = ExemplesSimples (EvalSimple)

let%test _ = EvalExemples.exemple1 = 7
let%test _ = EvalExemples.exemple2 = 42

module PrintSimple : ExprSimple with type t = string = struct
  type t = string

  let const c = string_of_int c
  let plus e1 e2 = "(" ^ e1 ^ " + " ^ e2 ^ ")"
  let mult e1 e2 = "(" ^ e1 ^ " * " ^ e2 ^ ")"
end

module CompteSimple : ExprSimple with type t = int = struct
  type t = int

  let const c = 0
  let plus e1 e2 = 1 + e1 + e2
  let mult e1 e2 = 1 + e1 + e2
end

module type ExprVar = sig
  type t

  val def : string -> t -> t -> t
  val var : string -> t
end

module type Expr = sig
  include ExprSimple
  include ExprVar with type t := t (* correspondance de type *)
end

module PrintVar : ExprVar with type t = string = struct
  type t = string

  let def x e1 e2 = "let " ^ x ^ " = " ^ e1 ^ " in " ^ e2
  let var x = x
end

module Print : Expr with type t = string = struct
  include PrintSimple
  include PrintVar
end

module Exo4 (E : Expr) = struct
  (* let x = 1 + 2 in x*3 *)
  let foo = E.(def "x" (plus (const 1) (const 2)) (mult (var "x") (const 3)))

  (* let x = 1 in let y = 2 in x + y *)
  let bar = E.(def "x" (const 1) (def "y" (const 2) (plus (var "x") (var "y"))))
end

module Exo4' = Exo4 (Print)

let%test _ = Exo4'.foo = "let x = (1 + 2) in (x * 3)"
let%test _ = Exo4'.bar = "let x = 1 in let y = 2 in (x + y)"

type env = (string * int) list

module EvalVar : ExprVar with type t = env -> int = struct
  type t = env -> int

  (* t est une fonction qui prend un environnement et retourne un entier *)
  (* x est une variable et e1/e2 des t -> donc ils prennent un env et retournent un int *)
  let def x e1 e2 env = e2 ((x, e1 env) :: env)

  (* List.assoc trouve le tuple de env qui contient x en 1er et renvoie le 2e elt *)
  let var x env = List.assoc x env
end

module EvalSimpleEnv : ExprSimple with type t = env -> int = struct
  type t = env -> int

  let const c env = c
  let plus e1 e2 env = e1 env + e2 env
  let mult e1 e2 env = e1 env * e2 env
end

module Eval : Expr with type t = env -> int = struct
  include EvalSimpleEnv
  include (EvalVar : ExprVar type t := t)
end
