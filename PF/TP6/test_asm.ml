open Asm

(* eval *)
let%test _ = eval (Plus (Entier 2, Entier 1)) = 3
let%test _ = eval (Entier 0) = 0
let%test _ = eval (Egal (Plus (Plus (Entier 1, Entier 2), Entier 3), Entier 6))
let%test _ = eval (Booleen true)
let%test _ = not (eval (Booleen false))

(* compile *)
let%test _ = compile (Plus (Entier 1, Entier 2)) = Seq (PushI 1, Seq (PushI 2, Add))

(* exec *)
(* TODO *)