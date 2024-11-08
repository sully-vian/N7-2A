open Tokens

(* Type du résultat d'une analyse syntaxique *)
type parseResult =
  | Success of inputStream
  | Failure
;;

(* accept : token -> inputStream -> parseResult *)
(* Vérifie que le premier token du flux d'entrée est bien le token attendu *)
(* et avance dans l'analyse si c'est le cas *)
let accept expected stream =
  match (peekAtFirstToken stream) with
    | token when (token = expected) ->
      (Success (advanceInStream stream))
    | _ -> Failure
;;

(* acceptIdent : inputStream -> parseResult *)
(* Vérifie que le premier token du flux d'entrée est bien un identifiant *)
(* et avance dans l'analyse si c'est le cas *)
let acceptIdent stream =
  match (peekAtFirstToken stream) with
    | (IDENT ident) -> (print_endline ident);(Success (advanceInStream stream))
    | _ -> Failure
;;

(* acceptNumber : inputStream -> parseResult *)
(* Vérifie que le premier token du flux d'entrée est bien un nombre *)
(* et avance dans l'analyse si c'est le cas *)
let acceptNumber stream =
  match (peekAtFirstToken stream) with
    | (ENTIER number) -> (print_endline (string_of_int number)); (Success (advanceInStream stream))
    | _ -> Failure
;;

(* Définition de la monade  qui est composée de : *)
(* - le type de donnée monadique : parseResult  *)
(* - la fonction : inject qui construit ce type à partir d'une liste de terminaux *)
(* - la fonction : bind (opérateur >>=) qui combine les fonctions d'analyse. *)

(* inject inputStream -> parseResult *)
(* Construit le type de la monade à partir d'une liste de terminaux *)
let inject s = Success s;;

(* bind : 'a m -> ('a -> 'b m) -> 'b m *)
(* bind (opérateur >>=) qui combine les fonctions d'analyse. *)
(* ici on utilise une version spécialisée de bind :
   'b  ->  inputStream
   'a  ->  inputStream
    m  ->  parseResult
*)
(* >>= : parseResult -> (inputStream -> parseResult) -> parseResult *)
let (>>=) result f =
  match result with
    | Success next -> f next
    | Failure -> Failure
;;


(* parseS : inputStream -> parseResult *)
(* Analyse du non terminal Programme *)
let rec parseS stream =
  (print_endline "S -> ");
  (match (peekAtFirstToken stream) with
    (* A COMPLETER *)
    | PAROUV ->
      inject stream >>=
      accept PAROUV >>=
      parseX >>=
      accept PARFER
    | IDENT _ -> 
      inject stream >>=
      acceptIdent
    | ENTIER _ ->
      inject stream >>=
      acceptNumber
    | _ -> Failure)



(* parseX : inputStream -> parseResult *)
(* Analyse du non terminal Expression *)
and parseX stream =
  (print_endline "X -> ");
  (match (peekAtFirstToken stream) with
    (* A COMPLETER *)
    | PARFER ->
      inject stream
    | (PAROUV | IDENT _ | ENTIER _) ->
      inject stream >>=
      parseS >>=
      parseY
    | _ -> Failure)


(* parseY : inputStream -> parseResult *)
(* Analyse du non terminal Y *)
and parseY stream =
  (print_endline "Y -> ");
  (match (peekAtFirstToken stream) with
    (* A COMPLETER *)
    | POINT ->
    inject stream >>=
    accept POINT >>=
    parseS
    | (PAROUV | IDENT _ | ENTIER _ | PARFER) ->
      inject stream >>=
      parseL
    | _ -> Failure)


(* parseL : inputStream -> parseResult *)
(* Analyse du non terminal L *)
and parseL stream =
  (print_endline "L -> ");
  (match (peekAtFirstToken stream) with
    (* A COMPLETER *)
    | (PAROUV | IDENT _ | ENTIER _ ) ->
      inject stream >>=
      parseS >>=
      parseL
    | PARFER ->
      inject stream
    | _ -> Failure)

;;
