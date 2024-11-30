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

(* fonction principale de parsing des programmes LOGO *)
let parse_logo flux = run (map fst (parse_P *> p_eof)) flux

(* fonctions auxiliaires *)
(* flux construit à partir des caractères de la chaîne s *)
let flux_of_string s =
  Flux.unfold
    (fun (i, l) -> if i = l then None else Some (s.[i], (i + 1, l)))
    (0, String.length s)
;;

(* flux construit à partir du contenu du fichier 'name' *)
let flux_of_file name =
  let f = open_in name in
  Flux.unfold
    (fun () ->
      try Some (input_char f, ()) with
      | End_of_file ->
        close_in f;
        None)
    ()
;;

(* conversion d'un programme en chaîne de caractères *)
let rec logo_to_string (d, i) =
  String.concat ";\n" (List.map decl_to_string d)
  ^ String.concat "; " (List.map cmd_to_string i)

(* conversion d'une déclaration en chaîne de caractères *)
and decl_to_string (Decl (nom, programme)) =
  Format.sprintf "proc %s %s " nom (logo_to_string programme)

(* conversion d'une commande en chaîne de caractères *)
and cmd_to_string c =
  match c with
  | Repeat (n, p) -> Format.sprintf "repeat %d %s" n (logo_to_string p)
  | Move d -> Format.sprintf "move %d" d
  | Turn a -> Format.sprintf "turn %d" a
  | On -> Format.sprintf "on"
  | Off -> Format.sprintf "off"
  | Call nom -> Format.sprintf "call %s" nom
;;

(* affichage des programmes LOGO solutions du parsing *)
let rec print_solutions progs =
  match Solution.uncons progs with
  | None -> ()
  | Some (p, q) ->
    Format.printf "LOGO program recognized: %s@." (logo_to_string p);
    print_solutions q
;;

(* programme interactif de test qui parse un programme LOGO lu au clavier *)
(* puis affiche tous les parsings possibles                               *)
let test_parser_logo () =
  let rec loop () =
    Format.printf "programme?@.";
    flush stdout;
    let l = read_line () in
    let f = flux_of_string l in
    let progs = parse_logo f in
    match Solution.uncons progs with
    | None ->
      Format.printf "** parsing failed ! **@.";
      loop ()
    | Some (p, q) ->
      print_solutions (Solution.cons p q);
      loop ()
  in
  loop ()
;;

(* conversion de degrés en radians *)
let rad_of_deg = 2. *. Float.pi /. 360.

let rec assoc_decls : string -> decls -> prog option =
  fun nom declarations ->
  match declarations with
  | [] -> None
  | Decl (h_nom, programme) :: t ->
    if nom = h_nom then Some programme else assoc_decls nom t
;;

type etat = bool * float * float * float

(* exécution d'un programme LOGO *)
let rec exec_logo : etat -> prog -> etat =
  fun (on, x, y, a) (declarations, instructions) ->
  fst (List.fold_left exec_cmd ((on, x, y, a), declarations) instructions)

and exec_cmd : etat * decls -> cmd -> etat * decls =
  fun ((on, x, y, a), declarations) commande ->
  match commande with
  | Repeat (n, p) ->
    if n <= 0
    then (on, x, y, a), declarations
    else exec_cmd (exec_logo (on, x, y, a) p, declarations) (Repeat (n - 1, p))
  | Move d ->
    let x' = x +. (float_of_int d *. cos (rad_of_deg *. a))
    and y' = y +. (float_of_int d *. sin (rad_of_deg *. a)) in
    (if on then Graphics.lineto else Graphics.moveto) (int_of_float x') (int_of_float y');
    (on, x', y', a), declarations
  | Turn b -> (on, x, y, mod_float (a +. float_of_int b) 360.), declarations
  | On -> (true, x, y, a), declarations
  | Off -> (false, x, y, a), declarations
  | Call nom ->
    (match assoc_decls nom declarations with
     | None -> failwith ("missing program declaration : " ^ nom)
     | Some programme -> exec_logo (on, x, y, a) programme, declarations)
;;

let run_logo programme =
  Graphics.open_graph " 800*600";
  Graphics.moveto 400 300;
  ignore (exec_logo (false, 400., 300., 0.) programme);
  ignore (read_line ());
  Graphics.close_graph ()
;;

let exec_file : string -> unit =
  fun nom ->
  Format.printf "parsing file %s@." nom;
  let f = flux_of_file nom in
  let progs = parse_logo f in
  match Solution.uncons progs with
  | None -> Format.printf "** parsing failed ! **@."
  | Some (p, q) ->
    Format.printf "LOGO program recognized: %s@." (logo_to_string p);
    run_logo p
;;

let () = exec_file Sys.argv.(1)
