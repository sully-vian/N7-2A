
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | VOID
    | VIRG
    | VIDE
    | TYPEIDENT of (
# 16 "parserJava.mly"
       (string)
# 18 "parserJava.ml"
  )
    | TANTQUE
    | STRING
    | SINON
    | SI
    | RETOUR
    | PTVIRG
    | PAROUV
    | PARFER
    | OPSUPEG
    | OPSUP
    | OPPT
    | OPPLUS
    | OPOU
    | OPNONEG
    | OPNON
    | OPMULT
    | OPMOINS
    | OPMOD
    | OPINFEG
    | OPINF
    | OPET
    | OPEG
    | OPDIV
    | NOUVEAU
    | INT
    | IMPORT
    | IDENT of (
# 16 "parserJava.mly"
       (string)
# 49 "parserJava.ml"
  )
    | FLOTTANT of (
# 23 "parserJava.mly"
       (float)
# 54 "parserJava.ml"
  )
    | FLOAT
    | FIN
    | ENTIER of (
# 22 "parserJava.mly"
       (int)
# 61 "parserJava.ml"
  )
    | CROOUV
    | CROFER
    | CHAR
    | CHAINE of (
# 26 "parserJava.mly"
       (string)
# 69 "parserJava.ml"
  )
    | CARACTERE of (
# 25 "parserJava.mly"
       (char)
# 74 "parserJava.ml"
  )
    | BOOLEEN of (
# 24 "parserJava.mly"
       (bool)
# 79 "parserJava.ml"
  )
    | BOOL
    | ASSIGN
    | ACCOUV
    | ACCFER
  
end

include MenhirBasics

# 1 "parserJava.mly"
  

(* Partie recopiee dans le fichier CaML genere. *)
(* Ouverture de modules exploites dans les actions *)
(* Declarations de types, de constantes, de fonctions, d'exceptions exploites dans les actions *)

(* let nbrVariables = ref 0;; *)

let nbrFonctions = ref 0;;


# 102 "parserJava.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState00 : ('s, _menhir_box_fichier) _menhir_state
    (** State 00.
        Stack shape : .
        Start symbol: fichier. *)

  | MenhirState03 : (('s, _menhir_box_fichier) _menhir_cell1_VOID _menhir_cell0_IDENT, _menhir_box_fichier) _menhir_state
    (** State 03.
        Stack shape : VOID IDENT.
        Start symbol: fichier. *)

  | MenhirState11 : (('s _menhir_cell0_IDENT, _menhir_box_fichier) _menhir_cell1_typeStruct _menhir_cell0_IDENT, _menhir_box_fichier) _menhir_state
    (** State 11.
        Stack shape : IDENT typeStruct IDENT.
        Start symbol: fichier. *)

  | MenhirState12 : ((('s, _menhir_box_fichier) _menhir_cell1_typeStruct _menhir_cell0_IDENT, _menhir_box_fichier) _menhir_cell1_VIRG, _menhir_box_fichier) _menhir_state
    (** State 12.
        Stack shape : typeStruct IDENT VIRG.
        Start symbol: fichier. *)

  | MenhirState14 : (((('s, _menhir_box_fichier) _menhir_cell1_typeStruct _menhir_cell0_IDENT, _menhir_box_fichier) _menhir_cell1_VIRG, _menhir_box_fichier) _menhir_cell1_typeStruct _menhir_cell0_IDENT, _menhir_box_fichier) _menhir_state
    (** State 14.
        Stack shape : typeStruct IDENT VIRG typeStruct IDENT.
        Start symbol: fichier. *)

  | MenhirState25 : (('s, _menhir_box_fichier) _menhir_cell1_typeStruct _menhir_cell0_IDENT, _menhir_box_fichier) _menhir_state
    (** State 25.
        Stack shape : typeStruct IDENT.
        Start symbol: fichier. *)

  | MenhirState30 : (('s, _menhir_box_fichier) _menhir_cell1_fonction, _menhir_box_fichier) _menhir_state
    (** State 30.
        Stack shape : fonction.
        Start symbol: fichier. *)

  | MenhirState33 : (('s, _menhir_box_fichier) _menhir_cell1_entete, _menhir_box_fichier) _menhir_state
    (** State 33.
        Stack shape : entete.
        Start symbol: fichier. *)

  | MenhirState34 : ((('s, _menhir_box_fichier) _menhir_cell1_entete, _menhir_box_fichier) _menhir_cell1_variables, _menhir_box_fichier) _menhir_state
    (** State 34.
        Stack shape : entete variables.
        Start symbol: fichier. *)

  | MenhirState35 : (((('s, _menhir_box_fichier) _menhir_cell1_entete, _menhir_box_fichier) _menhir_cell1_variables, _menhir_box_fichier) _menhir_cell1_RETOUR, _menhir_box_fichier) _menhir_state
    (** State 35.
        Stack shape : entete variables RETOUR.
        Start symbol: fichier. *)

  | MenhirState36 : (('s, _menhir_box_fichier) _menhir_cell1_OPPLUS, _menhir_box_fichier) _menhir_state
    (** State 36.
        Stack shape : OPPLUS.
        Start symbol: fichier. *)

  | MenhirState41 : (('s, _menhir_box_fichier) _menhir_cell1_expression, _menhir_box_fichier) _menhir_state
    (** State 41.
        Stack shape : expression.
        Start symbol: fichier. *)

  | MenhirState43 : (('s, _menhir_box_fichier) _menhir_cell1_expression, _menhir_box_fichier) _menhir_state
    (** State 43.
        Stack shape : expression.
        Start symbol: fichier. *)

  | MenhirState50 : (('s, _menhir_box_fichier) _menhir_cell1_variable, _menhir_box_fichier) _menhir_state
    (** State 50.
        Stack shape : variable.
        Start symbol: fichier. *)


and ('s, 'r) _menhir_cell1_entete = 
  | MenhirCell1_entete of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_expression = 
  | MenhirCell1_expression of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_fonction = 
  | MenhirCell1_fonction of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_typeBase = 
  | MenhirCell1_typeBase of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_typeStruct = 
  | MenhirCell1_typeStruct of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_variable = 
  | MenhirCell1_variable of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_variables = 
  | MenhirCell1_variables of 's * ('s, 'r) _menhir_state * (int)

and 's _menhir_cell0_IDENT = 
  | MenhirCell0_IDENT of 's * (
# 16 "parserJava.mly"
       (string)
# 201 "parserJava.ml"
)

and ('s, 'r) _menhir_cell1_OPPLUS = 
  | MenhirCell1_OPPLUS of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_RETOUR = 
  | MenhirCell1_RETOUR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_VIRG = 
  | MenhirCell1_VIRG of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_VOID = 
  | MenhirCell1_VOID of 's * ('s, 'r) _menhir_state

and _menhir_box_fichier = 
  | MenhirBox_fichier of (unit) [@@unboxed]

let _menhir_action_01 =
  fun _2 ->
    (
# 88 "parserJava.mly"
     (
	(print_endline "bloc : ACCOUV variables instructions ACCFER");
	(print_string "Nombre de variables = ");
	(print_int _2);
	(print_newline ())
	)
# 229 "parserJava.ml"
     : (unit))

let _menhir_action_02 =
  fun () ->
    (
# 73 "parserJava.mly"
                                 ( (print_endline "declTab : /* Lambda, mot vide */") )
# 237 "parserJava.ml"
     : (unit))

let _menhir_action_03 =
  fun () ->
    (
# 74 "parserJava.mly"
                        ( (print_endline "declTab : CROOUV CROFER") )
# 245 "parserJava.ml"
     : (unit))

let _menhir_action_04 =
  fun () ->
    (
# 78 "parserJava.mly"
                                                    ( (print_endline "entete : typeStruct IDENT PAROUV parsFormels PARFER") )
# 253 "parserJava.ml"
     : (unit))

let _menhir_action_05 =
  fun () ->
    (
# 79 "parserJava.mly"
                                              ( (print_endline "entete : VOID IDENT PAROUV parsFormels PARFER") )
# 261 "parserJava.ml"
     : (unit))

let _menhir_action_06 =
  fun () ->
    (
# 116 "parserJava.mly"
                    ( (print_endline "expression : ENTIER") )
# 269 "parserJava.ml"
     : (unit))

let _menhir_action_07 =
  fun () ->
    (
# 117 "parserJava.mly"
                                   ((print_endline "expression : expression OPPLUS expression"))
# 277 "parserJava.ml"
     : (unit))

let _menhir_action_08 =
  fun () ->
    (
# 119 "parserJava.mly"
                                   ()
# 285 "parserJava.ml"
     : (unit))

let _menhir_action_09 =
  fun () ->
    (
# 121 "parserJava.mly"
                                    ()
# 293 "parserJava.ml"
     : (unit))

let _menhir_action_10 =
  fun () ->
    (
# 59 "parserJava.mly"
                        ( (print_endline "fichier : programme FIN");(print_string "Nombre de fonctions : ");(print_int !nbrFonctions);(print_newline()) )
# 301 "parserJava.ml"
     : (unit))

let _menhir_action_11 =
  fun () ->
    (
# 76 "parserJava.mly"
                        ( (print_endline "fonction : entete bloc") )
# 309 "parserJava.ml"
     : (unit))

let _menhir_action_12 =
  fun () ->
    (
# 112 "parserJava.mly"
                                               ( (print_endline "instruction : expression PTVIRG") )
# 317 "parserJava.ml"
     : (unit))

let _menhir_action_13 =
  fun () ->
    (
# 113 "parserJava.mly"
                                                         ( (print_endline "instruction : RETURN expression PTVIRG") )
# 325 "parserJava.ml"
     : (unit))

let _menhir_action_14 =
  fun () ->
    (
# 109 "parserJava.mly"
                           ( (print_endline "instructions : instruction") )
# 333 "parserJava.ml"
     : (unit))

let _menhir_action_15 =
  fun () ->
    (
# 81 "parserJava.mly"
                                     ( (print_endline "parsFormels : /* Lambda, mot vide */") )
# 341 "parserJava.ml"
     : (unit))

let _menhir_action_16 =
  fun () ->
    (
# 82 "parserJava.mly"
                                                ( (print_endline "parsFormels : typeStruct IDENT suiteParsFormels") )
# 349 "parserJava.ml"
     : (unit))

let _menhir_action_17 =
  fun () ->
    (
# 61 "parserJava.mly"
                                   ( (nbrFonctions := 0); (print_endline "programme : /* Lambda, mot vide */") )
# 357 "parserJava.ml"
     : (unit))

let _menhir_action_18 =
  fun () ->
    (
# 62 "parserJava.mly"
                               ( (nbrFonctions := !nbrFonctions + 1);(print_endline "programme : fonction programme") )
# 365 "parserJava.ml"
     : (unit))

let _menhir_action_19 =
  fun () ->
    (
# 84 "parserJava.mly"
                                          ( (print_endline "suiteParsFormels : /* Lambda, mot vide */") )
# 373 "parserJava.ml"
     : (unit))

let _menhir_action_20 =
  fun () ->
    (
# 85 "parserJava.mly"
                                                          ( (print_endline "suiteParsFormels : VIRG typeStruct IDENT suiteParsFormels") )
# 381 "parserJava.ml"
     : (unit))

let _menhir_action_21 =
  fun () ->
    (
# 66 "parserJava.mly"
               ( (print_endline "typeBase : INT") )
# 389 "parserJava.ml"
     : (unit))

let _menhir_action_22 =
  fun () ->
    (
# 67 "parserJava.mly"
                 ( (print_endline "typeBase : FLOAT") )
# 397 "parserJava.ml"
     : (unit))

let _menhir_action_23 =
  fun () ->
    (
# 68 "parserJava.mly"
                ( (print_endline "typeBase : BOOL") )
# 405 "parserJava.ml"
     : (unit))

let _menhir_action_24 =
  fun () ->
    (
# 69 "parserJava.mly"
                ( (print_endline "typeBase : CHAR") )
# 413 "parserJava.ml"
     : (unit))

let _menhir_action_25 =
  fun () ->
    (
# 70 "parserJava.mly"
                  ( (print_endline "typeBase : STRING") )
# 421 "parserJava.ml"
     : (unit))

let _menhir_action_26 =
  fun () ->
    (
# 71 "parserJava.mly"
                     ( (print_endline "typeBase : TYPEIDENT") )
# 429 "parserJava.ml"
     : (unit))

let _menhir_action_27 =
  fun () ->
    (
# 64 "parserJava.mly"
                              ( (print_endline "typeStruct : typeBase declTab") )
# 437 "parserJava.ml"
     : (unit))

let _menhir_action_28 =
  fun () ->
    (
# 106 "parserJava.mly"
                                   ( (print_endline "variable : typeStruct IDENT PTVIRG") )
# 445 "parserJava.ml"
     : (unit))

let _menhir_action_29 =
  fun () ->
    (
# 96 "parserJava.mly"
   (
		(print_endline "variables : /* Lambda, mot vide */");
		0
		)
# 456 "parserJava.ml"
     : (int))

let _menhir_action_30 =
  fun _2 ->
    (
# 101 "parserJava.mly"
   (
		(print_endline "variables : variable variables");
		(_2 + 1)
		)
# 467 "parserJava.ml"
     : (int))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | ACCFER ->
        "ACCFER"
    | ACCOUV ->
        "ACCOUV"
    | ASSIGN ->
        "ASSIGN"
    | BOOL ->
        "BOOL"
    | BOOLEEN _ ->
        "BOOLEEN"
    | CARACTERE _ ->
        "CARACTERE"
    | CHAINE _ ->
        "CHAINE"
    | CHAR ->
        "CHAR"
    | CROFER ->
        "CROFER"
    | CROOUV ->
        "CROOUV"
    | ENTIER _ ->
        "ENTIER"
    | FIN ->
        "FIN"
    | FLOAT ->
        "FLOAT"
    | FLOTTANT _ ->
        "FLOTTANT"
    | IDENT _ ->
        "IDENT"
    | IMPORT ->
        "IMPORT"
    | INT ->
        "INT"
    | NOUVEAU ->
        "NOUVEAU"
    | OPDIV ->
        "OPDIV"
    | OPEG ->
        "OPEG"
    | OPET ->
        "OPET"
    | OPINF ->
        "OPINF"
    | OPINFEG ->
        "OPINFEG"
    | OPMOD ->
        "OPMOD"
    | OPMOINS ->
        "OPMOINS"
    | OPMULT ->
        "OPMULT"
    | OPNON ->
        "OPNON"
    | OPNONEG ->
        "OPNONEG"
    | OPOU ->
        "OPOU"
    | OPPLUS ->
        "OPPLUS"
    | OPPT ->
        "OPPT"
    | OPSUP ->
        "OPSUP"
    | OPSUPEG ->
        "OPSUPEG"
    | PARFER ->
        "PARFER"
    | PAROUV ->
        "PAROUV"
    | PTVIRG ->
        "PTVIRG"
    | RETOUR ->
        "RETOUR"
    | SI ->
        "SI"
    | SINON ->
        "SINON"
    | STRING ->
        "STRING"
    | TANTQUE ->
        "TANTQUE"
    | TYPEIDENT _ ->
        "TYPEIDENT"
    | VIDE ->
        "VIDE"
    | VIRG ->
        "VIRG"
    | VOID ->
        "VOID"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37"]
  
  let _menhir_run_28 : type  ttv_stack. ttv_stack -> _menhir_box_fichier =
    fun _menhir_stack ->
      let _v = _menhir_action_10 () in
      MenhirBox_fichier _v
  
  let rec _menhir_run_31 : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_fonction -> _menhir_box_fichier =
    fun _menhir_stack ->
      let MenhirCell1_fonction (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _ = _menhir_action_18 () in
      _menhir_goto_programme _menhir_stack _menhir_s
  
  and _menhir_goto_programme : type  ttv_stack. ttv_stack -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_s ->
      match _menhir_s with
      | MenhirState30 ->
          _menhir_run_31 _menhir_stack
      | MenhirState00 ->
          _menhir_run_28 _menhir_stack
      | _ ->
          _menhir_fail ()
  
  let rec _menhir_run_01 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_VOID (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | PAROUV ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TYPEIDENT _ ->
                  _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState03
              | STRING ->
                  _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState03
              | INT ->
                  _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState03
              | FLOAT ->
                  _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState03
              | CHAR ->
                  _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState03
              | BOOL ->
                  _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState03
              | PARFER ->
                  let _ = _menhir_action_15 () in
                  _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_04 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_26 () in
      _menhir_goto_typeBase _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_typeBase : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_typeBase (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | CROOUV ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | CROFER ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _ = _menhir_action_03 () in
              _menhir_goto_declTab _menhir_stack _menhir_lexbuf _menhir_lexer _tok
          | _ ->
              _eRR ())
      | IDENT _ ->
          let _ = _menhir_action_02 () in
          _menhir_goto_declTab _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_declTab : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_typeBase -> _ -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let MenhirCell1_typeBase (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _v = _menhir_action_27 () in
      _menhir_goto_typeStruct _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_typeStruct : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState33 ->
          _menhir_run_52 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
      | MenhirState50 ->
          _menhir_run_52 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
      | MenhirState30 ->
          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState00 ->
          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState12 ->
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState25 ->
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState03 ->
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_52 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | IDENT _ ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | PTVIRG ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_28 () in
              let _menhir_stack = MenhirCell1_variable (_menhir_stack, _menhir_s, _v) in
              (match (_tok : MenhirBasics.token) with
              | TYPEIDENT _ ->
                  _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState50
              | STRING ->
                  _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState50
              | INT ->
                  _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState50
              | FLOAT ->
                  _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState50
              | CHAR ->
                  _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState50
              | BOOL ->
                  _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState50
              | ENTIER _ | OPPLUS | RETOUR ->
                  let _v_1 = _menhir_action_29 () in
                  _menhir_run_51 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 _tok
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_05 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_25 () in
      _menhir_goto_typeBase _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_06 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_21 () in
      _menhir_goto_typeBase _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_07 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_22 () in
      _menhir_goto_typeBase _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_08 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_24 () in
      _menhir_goto_typeBase _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_09 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_23 () in
      _menhir_goto_typeBase _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_51 : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_variable -> _ -> _ -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_variable (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _2 = _v in
      let _v = _menhir_action_30 _2 in
      _menhir_goto_variables _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_variables : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState50 ->
          _menhir_run_51 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState33 ->
          _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_34 : type  ttv_stack. ((ttv_stack, _menhir_box_fichier) _menhir_cell1_entete as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_variables (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | RETOUR ->
          let _menhir_stack = MenhirCell1_RETOUR (_menhir_stack, MenhirState34) in
          let _menhir_s = MenhirState35 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | OPPLUS ->
              _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ENTIER _ ->
              _menhir_run_37 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | OPPLUS ->
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState34
      | ENTIER _ ->
          _menhir_run_37 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState34
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_36 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_OPPLUS (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState36 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | OPPLUS ->
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ENTIER _ ->
          _menhir_run_37 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_37 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_06 () in
      _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_expression : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState34 ->
          _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState43 ->
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState41 ->
          _menhir_run_42 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState35 ->
          _menhir_run_39 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState36 ->
          _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_48 : type  ttv_stack. (((ttv_stack, _menhir_box_fichier) _menhir_cell1_entete, _menhir_box_fichier) _menhir_cell1_variables as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | PTVIRG ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _ = _menhir_action_12 () in
          _menhir_goto_instruction _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | OPPLUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OPMULT ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_43 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_goto_instruction : type  ttv_stack. ((ttv_stack, _menhir_box_fichier) _menhir_cell1_entete, _menhir_box_fichier) _menhir_cell1_variables -> _ -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let _ = _menhir_action_14 () in
      match (_tok : MenhirBasics.token) with
      | ACCFER ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_variables (_menhir_stack, _, _2) = _menhir_stack in
          let _ = _menhir_action_01 _2 in
          let MenhirCell1_entete (_menhir_stack, _menhir_s, _) = _menhir_stack in
          let _v = _menhir_action_11 () in
          let _menhir_stack = MenhirCell1_fonction (_menhir_stack, _menhir_s, _v) in
          (match (_tok : MenhirBasics.token) with
          | VOID ->
              _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState30
          | TYPEIDENT _ ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState30
          | STRING ->
              _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState30
          | INT ->
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState30
          | FLOAT ->
              _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState30
          | CHAR ->
              _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState30
          | BOOL ->
              _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState30
          | FIN ->
              let _ = _menhir_action_17 () in
              _menhir_run_31 _menhir_stack
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_41 : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_expression -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState41 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | OPPLUS ->
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ENTIER _ ->
          _menhir_run_37 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_43 : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_expression -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState43 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | OPPLUS ->
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ENTIER _ ->
          _menhir_run_37 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_44 : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_expression -> _ -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let MenhirCell1_expression (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _v = _menhir_action_08 () in
      _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_42 : type  ttv_stack. ((ttv_stack, _menhir_box_fichier) _menhir_cell1_expression as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | OPMULT ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_43 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OPPLUS | PTVIRG ->
          let MenhirCell1_expression (_menhir_stack, _menhir_s, _) = _menhir_stack in
          let _v = _menhir_action_07 () in
          _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_39 : type  ttv_stack. ((((ttv_stack, _menhir_box_fichier) _menhir_cell1_entete, _menhir_box_fichier) _menhir_cell1_variables, _menhir_box_fichier) _menhir_cell1_RETOUR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | PTVIRG ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_RETOUR (_menhir_stack, _) = _menhir_stack in
          let _ = _menhir_action_13 () in
          _menhir_goto_instruction _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | OPPLUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OPMULT ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_43 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_38 : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_OPPLUS -> _ -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let MenhirCell1_OPPLUS (_menhir_stack, _menhir_s) = _menhir_stack in
      let _v = _menhir_action_09 () in
      _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_23 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_typeStruct (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | IDENT _v_0 ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v_0) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | PAROUV ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TYPEIDENT _ ->
                  _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState25
              | STRING ->
                  _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState25
              | INT ->
                  _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState25
              | FLOAT ->
                  _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState25
              | CHAR ->
                  _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState25
              | BOOL ->
                  _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState25
              | PARFER ->
                  let _ = _menhir_action_15 () in
                  _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_26 : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_typeStruct _menhir_cell0_IDENT -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell0_IDENT (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_typeStruct (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _v = _menhir_action_04 () in
      _menhir_goto_entete _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_entete : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_entete (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | ACCOUV ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TYPEIDENT _ ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState33
          | STRING ->
              _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState33
          | INT ->
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState33
          | FLOAT ->
              _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState33
          | CHAR ->
              _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState33
          | BOOL ->
              _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState33
          | ENTIER _ | OPPLUS | RETOUR ->
              let _v_1 = _menhir_action_29 () in
              _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState33 _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_13 : type  ttv_stack. (((ttv_stack, _menhir_box_fichier) _menhir_cell1_typeStruct _menhir_cell0_IDENT, _menhir_box_fichier) _menhir_cell1_VIRG as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_typeStruct (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | IDENT _v_0 ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v_0) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VIRG ->
              _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState14
          | PARFER ->
              let _ = _menhir_action_19 () in
              _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_12 : type  ttv_stack. ((ttv_stack, _menhir_box_fichier) _menhir_cell1_typeStruct _menhir_cell0_IDENT as 'stack) -> _ -> _ -> ('stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_VIRG (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState12 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TYPEIDENT _ ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FLOAT ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | CHAR ->
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL ->
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_15 : type  ttv_stack. (((ttv_stack, _menhir_box_fichier) _menhir_cell1_typeStruct _menhir_cell0_IDENT, _menhir_box_fichier) _menhir_cell1_VIRG, _menhir_box_fichier) _menhir_cell1_typeStruct _menhir_cell0_IDENT -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let MenhirCell0_IDENT (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_typeStruct (_menhir_stack, _, _) = _menhir_stack in
      let MenhirCell1_VIRG (_menhir_stack, _menhir_s) = _menhir_stack in
      let _ = _menhir_action_20 () in
      _menhir_goto_suiteParsFormels _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
  
  and _menhir_goto_suiteParsFormels : type  ttv_stack. ((ttv_stack, _menhir_box_fichier) _menhir_cell1_typeStruct _menhir_cell0_IDENT as 'stack) -> _ -> _ -> ('stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      match _menhir_s with
      | MenhirState11 ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MenhirState14 ->
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_20 : type  ttv_stack. (ttv_stack _menhir_cell0_IDENT, _menhir_box_fichier) _menhir_cell1_typeStruct _menhir_cell0_IDENT -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let MenhirCell0_IDENT (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_typeStruct (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _ = _menhir_action_16 () in
      _menhir_goto_parsFormels _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
  
  and _menhir_goto_parsFormels : type  ttv_stack. (ttv_stack _menhir_cell0_IDENT as 'stack) -> _ -> _ -> ('stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      match _menhir_s with
      | MenhirState25 ->
          _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MenhirState03 ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_21 : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_VOID _menhir_cell0_IDENT -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell0_IDENT (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_VOID (_menhir_stack, _menhir_s) = _menhir_stack in
      let _v = _menhir_action_05 () in
      _menhir_goto_entete _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_10 : type  ttv_stack. (ttv_stack _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_typeStruct (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | IDENT _v_0 ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v_0) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VIRG ->
              _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState11
          | PARFER ->
              let _ = _menhir_action_19 () in
              _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  let _menhir_run_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | VOID ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | TYPEIDENT _ ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | STRING ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | INT ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | FLOAT ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | CHAR ->
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | BOOL ->
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | FIN ->
          let _ = _menhir_action_17 () in
          _menhir_run_28 _menhir_stack
      | _ ->
          _eRR ()
  
end

let fichier =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_fichier v = _menhir_run_00 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v

# 123 "parserJava.mly"
  

# 1135 "parserJava.ml"
