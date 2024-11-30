open Parsing
open Parser

(* un programme est une séquence de déclarations suivi d'une séquence d'instructions *)
type prog = decls * inst
and decls = decl list
and decl = Decl of string * prog (* declaration d'un sous-programme nommé *)
and inst = cmd list

and cmd =
  | Repeat of int * prog (* on repete n fois un programme *)
  | Move of int (* on se deplace de d pas dans la direction courante *)
  | Turn of int (* on tourne d'un angle a *)
  | On (* on pose le stylo sur la feuille *)
  | Off (* on leve le stylo *)
  | Call of string (* appel du sous programme par son nom *)

(* Parsers pour les terminaux du langege LOGO. *)
(* L'analyse lexicale est realisee à la main              *)
(* sur des flux de caracteres sans lexer externe          *)
(* Les parsers de mots-clés renvoient (), de type unit    *)
(* Le parser des constantes entieres renvoie la velur lue *)

(* 'droppe' le resultat d'un parser et le remplace par () *)
let drop p = map (fun x -> ()) p

(* Parser pour les espaces, retour-chariots, tabulation *)
let is_space c = String.contains " \t\r\n" c
let space = drop (ptest is_space)

(* Combinateur de parser qui consomme tous les espaces    *)
(* avant d'appeler le parser 'p'                          *)
let rec eat_space p flux = (map snd (space *> eat_space p) ++ p) flux

(* Parser qui reconnait le caractere 'c' *)
let p_car c = drop (ptest (( = ) c))

(* Parser qui reconnait la chaine 's' *)
let p_chaine s =
  let rec parse i = if i < 0 then return () else map fst (parse (i - 1) *> p_car s.[i]) in
  parse (String.length s - 1)
;;

(* ****************************************************** *)
(* Parsers pour la fin de fichier                         *)
(* ****************************************************** *)

let p_eof = eat_space pvide

(* ****************************************************** *)
(* Parsers pour les mots-clés                             *)
(* ****************************************************** *)

let p_ptvirg = eat_space (p_car ';')
let p_begin = eat_space (p_chaine "begin")
let p_end = eat_space (p_chaine "end")
let p_repeat = eat_space (p_chaine "repeat")
let p_move = eat_space (p_chaine "move")
let p_turn = eat_space (p_chaine "turn")
let p_on = eat_space (p_chaine "on")
let p_off = eat_space (p_chaine "off")
let p_proc = eat_space (p_chaine "proc")
let p_call = eat_space (p_chaine "call")

(* ****************************************************** *)
(* Parser pour les constantes entieres                    *)
(* ****************************************************** *)

(* Parser pour les chiffres *)
let is_chiffre c = String.contains "0123456789" c
let p_chiffre = ptest is_chiffre

let p_entier =
  let rec horner acc =
    p_chiffre
    >>= fun c ->
    let acc' = (10 * acc) + (Char.code c - Char.code '0') in
    horner acc' ++ return acc'
  in
  eat_space (horner 0)
;;

(* ****************************************************** *)
(* Parser pour les identifiants                           *)
(* ****************************************************** *)

let is_lettre c = ('a' <= c && c <= 'z') || ('A' <= c && c <= 'Z')
let p_lettre = ptest is_lettre

let p_ident =
  let rec aux acc =
    p_lettre
    >>= fun c ->
    let acc' = acc ^ String.make 1 c in
    aux acc' ++ return acc'
  in
  eat_space (aux "")
;;

(* Grammaire LL1 des programmes LOGO:
   P -> begin D I end
   I -> /\
   I -> C ; I
   D -> /\
   D -> S ; D
   S -> proc ident P
   C -> repeat entier P
   C -> move entier
   C -> turn entier
   C -> on
   C -> off
   C -> call ident
*)

(* les parsers mutuellement récursifs pour la grammaire ci-dessus: TODO *)
let rec parse_P : (char, prog) parser =
  fun flux ->
  (p_begin
   >>= fun _ ->
   parse_D
   >>= fun declarations ->
   parse_I >>= fun instruction -> p_end >>= fun _ -> return (declarations, instruction))
    flux

and parse_I : (char, inst) parser =
  fun flux ->
  (return []
   ++ (parse_C
       >>= fun commande ->
       p_ptvirg
       >>= fun _ -> parse_I >>= fun instruction -> return (commande :: instruction)))
    flux

and parse_D : (char, decls) parser =
  fun flux ->
  (return []
   ++ (parse_S
       >>= fun declaration ->
       p_ptvirg
       >>= fun _ -> parse_D >>= fun declarations -> return (declaration :: declarations))
  )
    flux

and parse_S : (char, decl) parser =
  fun flux ->
  (p_proc
   >>= fun _ ->
   p_ident
   >>= fun identifiant ->
   parse_P >>= fun programme -> return (Decl (identifiant, programme)))
    flux

and parse_C : (char, cmd) parser =
  fun flux ->
  ((p_repeat
    >>= fun _ ->
    p_entier
    >>= fun entier -> parse_P >>= fun programme -> return (Repeat (entier, programme)))
   ++ (p_move >>= fun _ -> p_entier >>= fun entier -> return (Move entier))
   ++ (p_turn >>= fun _ -> p_entier >>= fun entier -> return (Turn entier))
   ++ (p_on >>= fun _ -> return On)
   ++ (p_off >>= fun _ -> return Off)
   ++ (p_call >>= fun _ -> p_ident >>= fun identifiant -> return (Call identifiant)))
    flux
;;
