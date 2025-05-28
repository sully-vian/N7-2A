open Semantics
open MiniML
open Ast

let filePath num = Printf.sprintf "../../exemples/exemple-%02d.mml" num
let getValeur (_, v, _) = v
let getType (t, _, _) = t

(* Tests de non regression *)
let%test _ = print_endline "tests de valeur..." = ()
let%test _ = getValeur (miniML (filePath 00)) = IntegerValue 3
let%test _ = getValeur (miniML (filePath 01)) = IntegerValue (-8)
let%test _ = getValeur (miniML (filePath 02)) = IntegerValue 4
let%test _ = getValeur (miniML (filePath 03)) = IntegerValue 5
let%test _ = getValeur (miniML (filePath 04)) = IntegerValue 1
let%test _ = getValeur (miniML (filePath 05)) = IntegerValue 2
let%test _ = getValeur (miniML (filePath 06)) = IntegerValue 120
let%test _ = getValeur (miniML (filePath 07)) = IntegerValue 10
let%test _ = getValeur (miniML (filePath 08)) = IntegerValue 5

let%test _ =
  getValeur (miniML (filePath 09))
  = FrozenValue (FunctionNode ("x", AccessNode "x"), [])

let%test _ = getValeur (miniML (filePath 11)) = IntegerValue 120
let%test _ = getValeur (miniML (filePath 12)) = IntegerValue 120
let%test _ = getValeur (miniML (filePath 13)) = IntegerValue 11
let%test _ = getValeur (miniML (filePath 14)) = IntegerValue 2
let%test _ = getValeur (miniML (filePath 15)) = IntegerValue 3
let%test _ = getValeur (miniML (filePath 16)) = IntegerValue 3
let%test _ = getValeur (miniML (filePath 17)) = IntegerValue 0
let%test _ = getValeur (miniML (filePath 18)) = IntegerValue 0
let%test _ = getValeur (miniML (filePath 19)) = IntegerValue 1

let f =
  FunctionNode
    ( "x",
      IfthenelseNode
        (AccessNode "x", IntegerNode 0, CallNode (AccessNode "f", TrueNode)) )

let%test _ =
  getValeur (miniML (filePath 20))
  = FrozenValue (f, [ ("f", FrozenValue (LetrecNode ("f", f, f), [])) ])

(* Tests de type *)

let%test _ = print_endline "tests de type..." = ()
let%test _ = getType (miniML (filePath 00)) = IntegerType
let%test _ = getType (miniML (filePath 01)) = IntegerType
let%test _ = getType (miniML (filePath 02)) = IntegerType
let%test _ = getType (miniML (filePath 03)) = IntegerType
let%test _ = getType (miniML (filePath 04)) = IntegerType
let%test _ = getType (miniML (filePath 05)) = IntegerType
let%test _ = getType (miniML (filePath 06)) = IntegerType
let%test _ = getType (miniML (filePath 07)) = IntegerType
let%test _ = getType (miniML (filePath 08)) = IntegerType

let%test _ =
  getType (miniML (filePath 09))
  = FunctionType
      ( VariableType (ref Types.UnknownType, 1),
        VariableType (ref Types.UnknownType, 1) )

let%test _ = getType (miniML (filePath 11)) = IntegerType
let%test _ = getType (miniML (filePath 12)) = IntegerType
let%test _ = getType (miniML (filePath 13)) = IntegerType
let%test _ = getType (miniML (filePath 14)) = IntegerType
let%test _ = getType (miniML (filePath 15)) = IntegerType
let%test _ = getType (miniML (filePath 16)) = IntegerType
let%test _ = getType (miniML (filePath 17)) = IntegerType
let%test _ = getType (miniML (filePath 18)) = IntegerType
let%test _ = getType (miniML (filePath 19)) = IntegerType

let%test _ =
  getType (miniML (filePath 20)) = FunctionType (BooleanType, IntegerType)
