
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
  | MenhirState000 : ('s, _menhir_box_fichier) _menhir_state
    (** State 000.
        Stack shape : .
        Start symbol: fichier. *)

  | MenhirState003 : (('s, _menhir_box_fichier) _menhir_cell1_VOID _menhir_cell0_IDENT, _menhir_box_fichier) _menhir_state
    (** State 003.
        Stack shape : VOID IDENT.
        Start symbol: fichier. *)

  | MenhirState011 : (('s _menhir_cell0_IDENT, _menhir_box_fichier) _menhir_cell1_typeStruct _menhir_cell0_IDENT, _menhir_box_fichier) _menhir_state
    (** State 011.
        Stack shape : IDENT typeStruct IDENT.
        Start symbol: fichier. *)

  | MenhirState012 : ((('s, _menhir_box_fichier) _menhir_cell1_typeStruct _menhir_cell0_IDENT, _menhir_box_fichier) _menhir_cell1_VIRG, _menhir_box_fichier) _menhir_state
    (** State 012.
        Stack shape : typeStruct IDENT VIRG.
        Start symbol: fichier. *)

  | MenhirState014 : (((('s, _menhir_box_fichier) _menhir_cell1_typeStruct _menhir_cell0_IDENT, _menhir_box_fichier) _menhir_cell1_VIRG, _menhir_box_fichier) _menhir_cell1_typeStruct _menhir_cell0_IDENT, _menhir_box_fichier) _menhir_state
    (** State 014.
        Stack shape : typeStruct IDENT VIRG typeStruct IDENT.
        Start symbol: fichier. *)

  | MenhirState025 : (('s, _menhir_box_fichier) _menhir_cell1_typeStruct _menhir_cell0_IDENT, _menhir_box_fichier) _menhir_state
    (** State 025.
        Stack shape : typeStruct IDENT.
        Start symbol: fichier. *)

  | MenhirState030 : (('s, _menhir_box_fichier) _menhir_cell1_fonction, _menhir_box_fichier) _menhir_state
    (** State 030.
        Stack shape : fonction.
        Start symbol: fichier. *)

  | MenhirState032 : (('s, _menhir_box_fichier) _menhir_cell1_entete, _menhir_box_fichier) _menhir_state
    (** State 032.
        Stack shape : entete.
        Start symbol: fichier. *)

  | MenhirState033 : (('s, _menhir_box_fichier) _menhir_cell1_ACCOUV, _menhir_box_fichier) _menhir_state
    (** State 033.
        Stack shape : ACCOUV.
        Start symbol: fichier. *)

  | MenhirState034 : ((('s, _menhir_box_fichier) _menhir_cell1_ACCOUV, _menhir_box_fichier) _menhir_cell1_variables, _menhir_box_fichier) _menhir_state
    (** State 034.
        Stack shape : ACCOUV variables.
        Start symbol: fichier. *)

  | MenhirState036 : (('s, _menhir_box_fichier) _menhir_cell1_TANTQUE, _menhir_box_fichier) _menhir_state
    (** State 036.
        Stack shape : TANTQUE.
        Start symbol: fichier. *)

  | MenhirState037 : (('s, _menhir_box_fichier) _menhir_cell1_PAROUV, _menhir_box_fichier) _menhir_state
    (** State 037.
        Stack shape : PAROUV.
        Start symbol: fichier. *)

  | MenhirState045 : (('s, _menhir_box_fichier) _menhir_cell1_unairetoile, _menhir_box_fichier) _menhir_state
    (** State 045.
        Stack shape : unairetoile.
        Start symbol: fichier. *)

  | MenhirState046 : (('s, _menhir_box_fichier) _menhir_cell1_unaire, _menhir_box_fichier) _menhir_state
    (** State 046.
        Stack shape : unaire.
        Start symbol: fichier. *)

  | MenhirState054 : (('s, _menhir_box_fichier) _menhir_cell1_unairetoile _menhir_cell0_IDENT, _menhir_box_fichier) _menhir_state
    (** State 054.
        Stack shape : unairetoile IDENT.
        Start symbol: fichier. *)

  | MenhirState063 : (('s, _menhir_box_fichier) _menhir_cell1_unairetoile _menhir_cell0_exprouident, _menhir_box_fichier) _menhir_state
    (** State 063.
        Stack shape : unairetoile exprouident.
        Start symbol: fichier. *)

  | MenhirState064 : (('s, _menhir_box_fichier) _menhir_cell1_PAROUV, _menhir_box_fichier) _menhir_state
    (** State 064.
        Stack shape : PAROUV.
        Start symbol: fichier. *)

  | MenhirState069 : (('s, _menhir_box_fichier) _menhir_cell1_expression, _menhir_box_fichier) _menhir_state
    (** State 069.
        Stack shape : expression.
        Start symbol: fichier. *)

  | MenhirState071 : (('s, _menhir_box_fichier) _menhir_cell1_CROOUV, _menhir_box_fichier) _menhir_state
    (** State 071.
        Stack shape : CROOUV.
        Start symbol: fichier. *)

  | MenhirState075 : (('s, _menhir_box_fichier) _menhir_cell1_suffixe, _menhir_box_fichier) _menhir_state
    (** State 075.
        Stack shape : suffixe.
        Start symbol: fichier. *)

  | MenhirState077 : (('s, _menhir_box_fichier) _menhir_cell1_unairetoile _menhir_cell0_expr, _menhir_box_fichier) _menhir_state
    (** State 077.
        Stack shape : unairetoile expr.
        Start symbol: fichier. *)

  | MenhirState093 : ((('s, _menhir_box_fichier) _menhir_cell1_unairetoile _menhir_cell0_expr, _menhir_box_fichier) _menhir_cell1_binairetoile, _menhir_box_fichier) _menhir_state
    (** State 093.
        Stack shape : unairetoile expr binairetoile.
        Start symbol: fichier. *)

  | MenhirState095 : (('s, _menhir_box_fichier) _menhir_cell1_binaire, _menhir_box_fichier) _menhir_state
    (** State 095.
        Stack shape : binaire.
        Start symbol: fichier. *)

  | MenhirState098 : ((('s, _menhir_box_fichier) _menhir_cell1_TANTQUE, _menhir_box_fichier) _menhir_cell1_expression, _menhir_box_fichier) _menhir_state
    (** State 098.
        Stack shape : TANTQUE expression.
        Start symbol: fichier. *)

  | MenhirState101 : (('s, _menhir_box_fichier) _menhir_cell1_SI, _menhir_box_fichier) _menhir_state
    (** State 101.
        Stack shape : SI.
        Start symbol: fichier. *)

  | MenhirState103 : ((('s, _menhir_box_fichier) _menhir_cell1_SI, _menhir_box_fichier) _menhir_cell1_expression, _menhir_box_fichier) _menhir_state
    (** State 103.
        Stack shape : SI expression.
        Start symbol: fichier. *)

  | MenhirState105 : (((('s, _menhir_box_fichier) _menhir_cell1_SI, _menhir_box_fichier) _menhir_cell1_expression, _menhir_box_fichier) _menhir_cell1_bloc, _menhir_box_fichier) _menhir_state
    (** State 105.
        Stack shape : SI expression bloc.
        Start symbol: fichier. *)

  | MenhirState107 : (('s, _menhir_box_fichier) _menhir_cell1_RETOUR, _menhir_box_fichier) _menhir_state
    (** State 107.
        Stack shape : RETOUR.
        Start symbol: fichier. *)

  | MenhirState112 : (('s, _menhir_box_fichier) _menhir_cell1_instruction, _menhir_box_fichier) _menhir_state
    (** State 112.
        Stack shape : instruction.
        Start symbol: fichier. *)

  | MenhirState116 : (('s, _menhir_box_fichier) _menhir_cell1_variable, _menhir_box_fichier) _menhir_state
    (** State 116.
        Stack shape : variable.
        Start symbol: fichier. *)


and ('s, 'r) _menhir_cell1_binaire = 
  | MenhirCell1_binaire of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_binairetoile = 
  | MenhirCell1_binairetoile of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_bloc = 
  | MenhirCell1_bloc of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_entete = 
  | MenhirCell1_entete of 's * ('s, 'r) _menhir_state * (unit)

and 's _menhir_cell0_expr = 
  | MenhirCell0_expr of 's * (unit)

and ('s, 'r) _menhir_cell1_expression = 
  | MenhirCell1_expression of 's * ('s, 'r) _menhir_state * (unit)

and 's _menhir_cell0_exprouident = 
  | MenhirCell0_exprouident of 's * (unit)

and ('s, 'r) _menhir_cell1_fonction = 
  | MenhirCell1_fonction of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_instruction = 
  | MenhirCell1_instruction of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_suffixe = 
  | MenhirCell1_suffixe of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_typeBase = 
  | MenhirCell1_typeBase of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_typeStruct = 
  | MenhirCell1_typeStruct of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_unaire = 
  | MenhirCell1_unaire of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_unairetoile = 
  | MenhirCell1_unairetoile of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_variable = 
  | MenhirCell1_variable of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_variables = 
  | MenhirCell1_variables of 's * ('s, 'r) _menhir_state * (int)

and ('s, 'r) _menhir_cell1_ACCOUV = 
  | MenhirCell1_ACCOUV of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_CROOUV = 
  | MenhirCell1_CROOUV of 's * ('s, 'r) _menhir_state

and 's _menhir_cell0_IDENT = 
  | MenhirCell0_IDENT of 's * (
# 16 "parserJava.mly"
       (string)
# 314 "parserJava.ml"
)

and ('s, 'r) _menhir_cell1_PAROUV = 
  | MenhirCell1_PAROUV of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_RETOUR = 
  | MenhirCell1_RETOUR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_SI = 
  | MenhirCell1_SI of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_TANTQUE = 
  | MenhirCell1_TANTQUE of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_VIRG = 
  | MenhirCell1_VIRG of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_VOID = 
  | MenhirCell1_VOID of 's * ('s, 'r) _menhir_state

and _menhir_box_fichier = 
  | MenhirBox_fichier of (unit) [@@unboxed]

let _menhir_action_01 =
  fun () ->
    (
# 142 "parserJava.mly"
                 ((print_endline "binaire : ASSIGN"))
# 343 "parserJava.ml"
     : (unit))

let _menhir_action_02 =
  fun () ->
    (
# 143 "parserJava.mly"
         ((print_endline "binaire : OPPT"))
# 351 "parserJava.ml"
     : (unit))

let _menhir_action_03 =
  fun () ->
    (
# 144 "parserJava.mly"
           ((print_endline "binaire : OPPLUS"))
# 359 "parserJava.ml"
     : (unit))

let _menhir_action_04 =
  fun () ->
    (
# 145 "parserJava.mly"
            ((print_endline "binaire : OPMOINS"))
# 367 "parserJava.ml"
     : (unit))

let _menhir_action_05 =
  fun () ->
    (
# 146 "parserJava.mly"
           ((print_endline "binaire : OPMULT"))
# 375 "parserJava.ml"
     : (unit))

let _menhir_action_06 =
  fun () ->
    (
# 147 "parserJava.mly"
          ((print_endline "binaire : OPDIV"))
# 383 "parserJava.ml"
     : (unit))

let _menhir_action_07 =
  fun () ->
    (
# 148 "parserJava.mly"
          ((print_endline "binaire : OPMOD"))
# 391 "parserJava.ml"
     : (unit))

let _menhir_action_08 =
  fun () ->
    (
# 149 "parserJava.mly"
         ((print_endline "binaire : OPOU"))
# 399 "parserJava.ml"
     : (unit))

let _menhir_action_09 =
  fun () ->
    (
# 150 "parserJava.mly"
         ((print_endline "binaire : OPET"))
# 407 "parserJava.ml"
     : (unit))

let _menhir_action_10 =
  fun () ->
    (
# 151 "parserJava.mly"
         ((print_endline "binaire : OPEG"))
# 415 "parserJava.ml"
     : (unit))

let _menhir_action_11 =
  fun () ->
    (
# 152 "parserJava.mly"
            ((print_endline "binaire : OPNONEG"))
# 423 "parserJava.ml"
     : (unit))

let _menhir_action_12 =
  fun () ->
    (
# 153 "parserJava.mly"
          ((print_endline "binaire : OPINF"))
# 431 "parserJava.ml"
     : (unit))

let _menhir_action_13 =
  fun () ->
    (
# 154 "parserJava.mly"
          ((print_endline "binaire : OPSUP"))
# 439 "parserJava.ml"
     : (unit))

let _menhir_action_14 =
  fun () ->
    (
# 155 "parserJava.mly"
            ((print_endline "binaire : OPINFEG"))
# 447 "parserJava.ml"
     : (unit))

let _menhir_action_15 =
  fun () ->
    (
# 156 "parserJava.mly"
            ((print_endline "binaire : OPSUPEG"))
# 455 "parserJava.ml"
     : (unit))

let _menhir_action_16 =
  fun () ->
    (
# 139 "parserJava.mly"
                                      ()
# 463 "parserJava.ml"
     : (unit))

let _menhir_action_17 =
  fun () ->
    (
# 140 "parserJava.mly"
                                   ()
# 471 "parserJava.ml"
     : (unit))

let _menhir_action_18 =
  fun _2 ->
    (
# 88 "parserJava.mly"
     (
	(print_endline "bloc : ACCOUV variables instructions ACCFER");
	(print_string "Nombre de variables = ");
	(print_int _2);
	(print_newline ())
	)
# 484 "parserJava.ml"
     : (unit))

let _menhir_action_19 =
  fun () ->
    (
# 73 "parserJava.mly"
                                 ( (print_endline "declTab : /* Lambda, mot vide */") )
# 492 "parserJava.ml"
     : (unit))

let _menhir_action_20 =
  fun () ->
    (
# 74 "parserJava.mly"
                        ( (print_endline "declTab : CROOUV CROFER") )
# 500 "parserJava.ml"
     : (unit))

let _menhir_action_21 =
  fun () ->
    (
# 78 "parserJava.mly"
                                                    ( (print_endline "entete : typeStruct IDENT PAROUV parsFormels PARFER") )
# 508 "parserJava.ml"
     : (unit))

let _menhir_action_22 =
  fun () ->
    (
# 79 "parserJava.mly"
                                              ( (print_endline "entete : VOID IDENT PAROUV parsFormels PARFER") )
# 516 "parserJava.ml"
     : (unit))

let _menhir_action_23 =
  fun () ->
    (
# 120 "parserJava.mly"
              ((print_endline "expr : ENTIER"))
# 524 "parserJava.ml"
     : (unit))

let _menhir_action_24 =
  fun () ->
    (
# 121 "parserJava.mly"
             ((print_endline "expr : FLOTTANT"))
# 532 "parserJava.ml"
     : (unit))

let _menhir_action_25 =
  fun () ->
    (
# 122 "parserJava.mly"
         ((print_endline "expr : CHAR"))
# 540 "parserJava.ml"
     : (unit))

let _menhir_action_26 =
  fun () ->
    (
# 123 "parserJava.mly"
            ((print_endline "expr : BOOLEEN"))
# 548 "parserJava.ml"
     : (unit))

let _menhir_action_27 =
  fun () ->
    (
# 124 "parserJava.mly"
         ((print_endline "expr : VIDE"))
# 556 "parserJava.ml"
     : (unit))

let _menhir_action_28 =
  fun () ->
    (
# 125 "parserJava.mly"
                             ()
# 564 "parserJava.ml"
     : (unit))

let _menhir_action_29 =
  fun () ->
    (
# 126 "parserJava.mly"
                             ()
# 572 "parserJava.ml"
     : (unit))

let _menhir_action_30 =
  fun () ->
    (
# 128 "parserJava.mly"
                                           ()
# 580 "parserJava.ml"
     : (unit))

let _menhir_action_31 =
  fun () ->
    (
# 129 "parserJava.mly"
                                                ()
# 588 "parserJava.ml"
     : (unit))

let _menhir_action_32 =
  fun () ->
    (
# 172 "parserJava.mly"
                    ()
# 596 "parserJava.ml"
     : (unit))

let _menhir_action_33 =
  fun () ->
    (
# 173 "parserJava.mly"
                              ()
# 604 "parserJava.ml"
     : (unit))

let _menhir_action_34 =
  fun () ->
    (
# 169 "parserJava.mly"
                           ()
# 612 "parserJava.ml"
     : (unit))

let _menhir_action_35 =
  fun () ->
    (
# 170 "parserJava.mly"
                                ()
# 620 "parserJava.ml"
     : (unit))

let _menhir_action_36 =
  fun () ->
    (
# 166 "parserJava.mly"
                      ()
# 628 "parserJava.ml"
     : (unit))

let _menhir_action_37 =
  fun () ->
    (
# 167 "parserJava.mly"
                              ()
# 636 "parserJava.ml"
     : (unit))

let _menhir_action_38 =
  fun () ->
    (
# 59 "parserJava.mly"
                        ( (print_endline "fichier : programme FIN");(print_string "Nombre de fonctions : ");(print_int !nbrFonctions);(print_newline()) )
# 644 "parserJava.ml"
     : (unit))

let _menhir_action_39 =
  fun () ->
    (
# 76 "parserJava.mly"
                        ( (print_endline "fonction : entete bloc") )
# 652 "parserJava.ml"
     : (unit))

let _menhir_action_40 =
  fun () ->
    (
# 113 "parserJava.mly"
                                ( (print_endline "instruction : expression PTVIRG") )
# 660 "parserJava.ml"
     : (unit))

let _menhir_action_41 =
  fun () ->
    (
# 114 "parserJava.mly"
                                      ( (print_endline "instruction : SI PAROUV expression PARFER bloc") )
# 668 "parserJava.ml"
     : (unit))

let _menhir_action_42 =
  fun () ->
    (
# 115 "parserJava.mly"
                                                 ( (print_endline "instruction : SI PAROUV expression PARFER bloc SINON bloc") )
# 676 "parserJava.ml"
     : (unit))

let _menhir_action_43 =
  fun () ->
    (
# 116 "parserJava.mly"
                                           ( (print_endline "instruction : TANTQUE PAROUV expression PARFER bloc") )
# 684 "parserJava.ml"
     : (unit))

let _menhir_action_44 =
  fun () ->
    (
# 117 "parserJava.mly"
                                       ( (print_endline "instruction : RETURN expression PTVIRG") )
# 692 "parserJava.ml"
     : (unit))

let _menhir_action_45 =
  fun () ->
    (
# 109 "parserJava.mly"
                                      ((print_endline "instructions : /* Lambda, mot vide */"))
# 700 "parserJava.ml"
     : (unit))

let _menhir_action_46 =
  fun () ->
    (
# 110 "parserJava.mly"
                              ( (print_endline "instructions : instruction") )
# 708 "parserJava.ml"
     : (unit))

let _menhir_action_47 =
  fun () ->
    (
# 81 "parserJava.mly"
                                     ( (print_endline "parsFormels : /* Lambda, mot vide */") )
# 716 "parserJava.ml"
     : (unit))

let _menhir_action_48 =
  fun () ->
    (
# 82 "parserJava.mly"
                                                ( (print_endline "parsFormels : typeStruct IDENT suiteParsFormels") )
# 724 "parserJava.ml"
     : (unit))

let _menhir_action_49 =
  fun () ->
    (
# 61 "parserJava.mly"
                                   ( (nbrFonctions := 0); (print_endline "programme : /* Lambda, mot vide */") )
# 732 "parserJava.ml"
     : (unit))

let _menhir_action_50 =
  fun () ->
    (
# 62 "parserJava.mly"
                               ( (nbrFonctions := !nbrFonctions + 1);(print_endline "programme : fonction programme") )
# 740 "parserJava.ml"
     : (unit))

let _menhir_action_51 =
  fun () ->
    (
# 159 "parserJava.mly"
                        ()
# 748 "parserJava.ml"
     : (unit))

let _menhir_action_52 =
  fun () ->
    (
# 160 "parserJava.mly"
                           ()
# 756 "parserJava.ml"
     : (unit))

let _menhir_action_53 =
  fun () ->
    (
# 161 "parserJava.mly"
                             ()
# 764 "parserJava.ml"
     : (unit))

let _menhir_action_54 =
  fun () ->
    (
# 163 "parserJava.mly"
                                      ()
# 772 "parserJava.ml"
     : (unit))

let _menhir_action_55 =
  fun () ->
    (
# 164 "parserJava.mly"
                                    ()
# 780 "parserJava.ml"
     : (unit))

let _menhir_action_56 =
  fun () ->
    (
# 84 "parserJava.mly"
                                          ( (print_endline "suiteParsFormels : /* Lambda, mot vide */") )
# 788 "parserJava.ml"
     : (unit))

let _menhir_action_57 =
  fun () ->
    (
# 85 "parserJava.mly"
                                                          ( (print_endline "suiteParsFormels : VIRG typeStruct IDENT suiteParsFormels") )
# 796 "parserJava.ml"
     : (unit))

let _menhir_action_58 =
  fun () ->
    (
# 66 "parserJava.mly"
               ( (print_endline "typeBase : INT") )
# 804 "parserJava.ml"
     : (unit))

let _menhir_action_59 =
  fun () ->
    (
# 67 "parserJava.mly"
                 ( (print_endline "typeBase : FLOAT") )
# 812 "parserJava.ml"
     : (unit))

let _menhir_action_60 =
  fun () ->
    (
# 68 "parserJava.mly"
                ( (print_endline "typeBase : BOOL") )
# 820 "parserJava.ml"
     : (unit))

let _menhir_action_61 =
  fun () ->
    (
# 69 "parserJava.mly"
                ( (print_endline "typeBase : CHAR") )
# 828 "parserJava.ml"
     : (unit))

let _menhir_action_62 =
  fun () ->
    (
# 70 "parserJava.mly"
                  ( (print_endline "typeBase : STRING") )
# 836 "parserJava.ml"
     : (unit))

let _menhir_action_63 =
  fun () ->
    (
# 71 "parserJava.mly"
                     ( (print_endline "typeBase : TYPEIDENT") )
# 844 "parserJava.ml"
     : (unit))

let _menhir_action_64 =
  fun () ->
    (
# 64 "parserJava.mly"
                              ( (print_endline "typeStruct : typeBase declTab") )
# 852 "parserJava.ml"
     : (unit))

let _menhir_action_65 =
  fun () ->
    (
# 131 "parserJava.mly"
                                ()
# 860 "parserJava.ml"
     : (unit))

let _menhir_action_66 =
  fun () ->
    (
# 132 "parserJava.mly"
                            ()
# 868 "parserJava.ml"
     : (unit))

let _menhir_action_67 =
  fun () ->
    (
# 133 "parserJava.mly"
                          ()
# 876 "parserJava.ml"
     : (unit))

let _menhir_action_68 =
  fun () ->
    (
# 134 "parserJava.mly"
            ()
# 884 "parserJava.ml"
     : (unit))

let _menhir_action_69 =
  fun () ->
    (
# 136 "parserJava.mly"
                                     ()
# 892 "parserJava.ml"
     : (unit))

let _menhir_action_70 =
  fun () ->
    (
# 137 "parserJava.mly"
                                 ()
# 900 "parserJava.ml"
     : (unit))

let _menhir_action_71 =
  fun () ->
    (
# 106 "parserJava.mly"
                                   ( (print_endline "variable : typeStruct IDENT PTVIRG") )
# 908 "parserJava.ml"
     : (unit))

let _menhir_action_72 =
  fun () ->
    (
# 96 "parserJava.mly"
   (
		(print_endline "variables : /* Lambda, mot vide */");
		0
		)
# 919 "parserJava.ml"
     : (int))

let _menhir_action_73 =
  fun _2 ->
    (
# 101 "parserJava.mly"
   (
		(print_endline "variables : variable variables");
		(_2 + 1)
		)
# 930 "parserJava.ml"
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
  
  let _menhir_run_028 : type  ttv_stack. ttv_stack -> _menhir_box_fichier =
    fun _menhir_stack ->
      let _v = _menhir_action_38 () in
      MenhirBox_fichier _v
  
  let rec _menhir_run_031 : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_fonction -> _menhir_box_fichier =
    fun _menhir_stack ->
      let MenhirCell1_fonction (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _ = _menhir_action_50 () in
      _menhir_goto_programme _menhir_stack _menhir_s
  
  and _menhir_goto_programme : type  ttv_stack. ttv_stack -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_s ->
      match _menhir_s with
      | MenhirState030 ->
          _menhir_run_031 _menhir_stack
      | MenhirState000 ->
          _menhir_run_028 _menhir_stack
      | _ ->
          _menhir_fail ()
  
  let rec _menhir_run_001 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
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
                  _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState003
              | STRING ->
                  _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState003
              | INT ->
                  _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState003
              | FLOAT ->
                  _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState003
              | CHAR ->
                  _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState003
              | BOOL ->
                  _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState003
              | PARFER ->
                  let _ = _menhir_action_47 () in
                  _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_004 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_63 () in
      _menhir_goto_typeBase _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_typeBase : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState037 ->
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState033 ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState116 ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState030 ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState000 ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState025 ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState003 ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState012 ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_038 : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_PAROUV -> _ -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      match (_tok : MenhirBasics.token) with
      | PARFER ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_PAROUV (_menhir_stack, _menhir_s) = _menhir_stack in
          let _v = _menhir_action_65 () in
          _menhir_goto_unaire _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_unaire : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_unaire (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | PAROUV ->
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState046
      | OPPLUS ->
          _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState046
      | OPNON ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState046
      | OPMOINS ->
          _menhir_run_042 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState046
      | BOOLEEN _ | CHAR | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | VIDE ->
          let _ = _menhir_action_69 () in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_037 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_PAROUV (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState037 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TYPEIDENT _ ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FLOAT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | CHAR ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_005 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_62 () in
      _menhir_goto_typeBase _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_006 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_58 () in
      _menhir_goto_typeBase _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_007 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_59 () in
      _menhir_goto_typeBase _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_008 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_61 () in
      _menhir_goto_typeBase _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_009 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_60 () in
      _menhir_goto_typeBase _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_040 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_66 () in
      _menhir_goto_unaire _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_041 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_68 () in
      _menhir_goto_unaire _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_042 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_67 () in
      _menhir_goto_unaire _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_047 : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_unaire -> _ -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let MenhirCell1_unaire (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _v = _menhir_action_70 () in
      _menhir_goto_unairetoile _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_unairetoile : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState046 ->
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState112 ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState034 ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState107 ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState101 ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState093 ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState071 ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState069 ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState064 ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState054 ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState045 ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState036 ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_043 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_unairetoile (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | VIDE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_27 () in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | NOUVEAU ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v_2 ->
              let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v_2) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | PAROUV ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | PARFER ->
                      let _tok = _menhir_lexer _menhir_lexbuf in
                      let _ = _menhir_action_34 () in
                      _menhir_goto_exprourien _menhir_stack _menhir_lexbuf _menhir_lexer _tok
                  | _ ->
                      _eRR ())
              | CROOUV ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | PAROUV ->
                      _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState054
                  | OPPLUS ->
                      _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState054
                  | OPNON ->
                      _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState054
                  | OPMOINS ->
                      _menhir_run_042 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState054
                  | BOOLEEN _ | CHAR | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | VIDE ->
                      let _v_4 = _menhir_action_69 () in
                      _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer _v_4 MenhirState054 _tok
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | IDENT _ ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_32 () in
          _menhir_goto_exprouident _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | FLOTTANT _ ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_24 () in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | ENTIER _ ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_23 () in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | CHAR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_25 () in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | BOOLEEN _ ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_26 () in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_goto_expr : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_unairetoile -> _ -> _ -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _menhir_stack = MenhirCell0_expr (_menhir_stack, _v) in
      match (_tok : MenhirBasics.token) with
      | OPSUPEG ->
          _menhir_run_078 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState077
      | OPSUP ->
          _menhir_run_079 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState077
      | OPPT ->
          _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState077
      | OPPLUS ->
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState077
      | OPOU ->
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState077
      | OPNONEG ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState077
      | OPMULT ->
          _menhir_run_084 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState077
      | OPMOINS ->
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState077
      | OPMOD ->
          _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState077
      | OPINFEG ->
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState077
      | OPINF ->
          _menhir_run_088 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState077
      | OPET ->
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState077
      | OPEG ->
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState077
      | OPDIV ->
          _menhir_run_091 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState077
      | ASSIGN ->
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState077
      | BOOLEEN _ | CHAR | CROFER | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | OPNON | PARFER | PAROUV | PTVIRG | VIDE | VIRG ->
          let _v_0 = _menhir_action_16 () in
          _menhir_run_093 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState077 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_078 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_15 () in
      _menhir_goto_binaire _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_binaire : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_binaire (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | OPSUPEG ->
          _menhir_run_078 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState095
      | OPSUP ->
          _menhir_run_079 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState095
      | OPPT ->
          _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState095
      | OPPLUS ->
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState095
      | OPOU ->
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState095
      | OPNONEG ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState095
      | OPMULT ->
          _menhir_run_084 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState095
      | OPMOINS ->
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState095
      | OPMOD ->
          _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState095
      | OPINFEG ->
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState095
      | OPINF ->
          _menhir_run_088 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState095
      | OPET ->
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState095
      | OPEG ->
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState095
      | OPDIV ->
          _menhir_run_091 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState095
      | ASSIGN ->
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState095
      | BOOLEEN _ | CHAR | CROFER | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | OPNON | PARFER | PAROUV | PTVIRG | VIDE | VIRG ->
          let _ = _menhir_action_16 () in
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_079 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_13 () in
      _menhir_goto_binaire _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_080 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_02 () in
      _menhir_goto_binaire _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_081 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_03 () in
      _menhir_goto_binaire _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_082 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_08 () in
      _menhir_goto_binaire _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_083 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_11 () in
      _menhir_goto_binaire _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_084 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_05 () in
      _menhir_goto_binaire _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_085 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_04 () in
      _menhir_goto_binaire _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_086 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_07 () in
      _menhir_goto_binaire _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_087 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_14 () in
      _menhir_goto_binaire _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_088 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_12 () in
      _menhir_goto_binaire _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_089 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_09 () in
      _menhir_goto_binaire _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_090 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_10 () in
      _menhir_goto_binaire _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_091 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_06 () in
      _menhir_goto_binaire _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_092 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_01 () in
      _menhir_goto_binaire _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_096 : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_binaire -> _ -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let MenhirCell1_binaire (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _v = _menhir_action_17 () in
      _menhir_goto_binairetoile _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_binairetoile : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState095 ->
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState077 ->
          _menhir_run_093 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_093 : type  ttv_stack. ((ttv_stack, _menhir_box_fichier) _menhir_cell1_unairetoile _menhir_cell0_expr as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | PAROUV ->
          let _menhir_stack = MenhirCell1_binairetoile (_menhir_stack, _menhir_s, _v) in
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState093
      | OPNON ->
          let _menhir_stack = MenhirCell1_binairetoile (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState093
      | CROFER | PARFER | PTVIRG | VIRG ->
          let MenhirCell0_expr (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_unairetoile (_menhir_stack, _menhir_s, _) = _menhir_stack in
          let _v = _menhir_action_30 () in
          _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | BOOLEEN _ | CHAR | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | VIDE ->
          let _menhir_stack = MenhirCell1_binairetoile (_menhir_stack, _menhir_s, _v) in
          let _v_0 = _menhir_action_69 () in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState093 _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_goto_expression : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState034 ->
          _menhir_run_114 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
      | MenhirState112 ->
          _menhir_run_114 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
      | MenhirState107 ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState101 ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState036 ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState093 ->
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState071 ->
          _menhir_run_072 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState069 ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState064 ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState054 ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState045 ->
          _menhir_run_048 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_114 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | PTVIRG ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_40 () in
          _menhir_goto_instruction _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_instruction : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_instruction (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TANTQUE ->
          _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | SI ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | RETOUR ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | PAROUV ->
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | OPPLUS ->
          _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | OPNON ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | OPMOINS ->
          _menhir_run_042 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | ACCFER ->
          let _ = _menhir_action_45 () in
          _menhir_run_113 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BOOLEEN _ | CHAR | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | VIDE ->
          let _v_1 = _menhir_action_69 () in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState112 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_035 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_TANTQUE (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | PAROUV ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | PAROUV ->
              _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState036
          | OPPLUS ->
              _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState036
          | OPNON ->
              _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState036
          | OPMOINS ->
              _menhir_run_042 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState036
          | BOOLEEN _ | CHAR | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | VIDE ->
              let _v = _menhir_action_69 () in
              _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState036 _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_100 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_SI (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | PAROUV ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | PAROUV ->
              _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState101
          | OPPLUS ->
              _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState101
          | OPNON ->
              _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState101
          | OPMOINS ->
              _menhir_run_042 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState101
          | BOOLEEN _ | CHAR | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | VIDE ->
              let _v = _menhir_action_69 () in
              _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState101 _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_107 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_RETOUR (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | PAROUV ->
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState107
      | OPPLUS ->
          _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState107
      | OPNON ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState107
      | OPMOINS ->
          _menhir_run_042 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState107
      | BOOLEEN _ | CHAR | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | VIDE ->
          let _v = _menhir_action_69 () in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState107 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_113 : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_instruction -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let MenhirCell1_instruction (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _ = _menhir_action_46 () in
      _menhir_goto_instructions _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
  
  and _menhir_goto_instructions : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      match _menhir_s with
      | MenhirState112 ->
          _menhir_run_113 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MenhirState034 ->
          _menhir_run_110 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_110 : type  ttv_stack. ((ttv_stack, _menhir_box_fichier) _menhir_cell1_ACCOUV, _menhir_box_fichier) _menhir_cell1_variables -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_variables (_menhir_stack, _, _2) = _menhir_stack in
      let MenhirCell1_ACCOUV (_menhir_stack, _menhir_s) = _menhir_stack in
      let _v = _menhir_action_18 _2 in
      _menhir_goto_bloc _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_bloc : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState032 ->
          _menhir_run_121 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState105 ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState103 ->
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState098 ->
          _menhir_run_099 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_121 : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_entete -> _ -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let MenhirCell1_entete (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _v = _menhir_action_39 () in
      let _menhir_stack = MenhirCell1_fonction (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | VOID ->
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState030
      | TYPEIDENT _ ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState030
      | STRING ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState030
      | INT ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState030
      | FLOAT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState030
      | CHAR ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState030
      | BOOL ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState030
      | FIN ->
          let _ = _menhir_action_49 () in
          _menhir_run_031 _menhir_stack
      | _ ->
          _eRR ()
  
  and _menhir_run_106 : type  ttv_stack. (((ttv_stack, _menhir_box_fichier) _menhir_cell1_SI, _menhir_box_fichier) _menhir_cell1_expression, _menhir_box_fichier) _menhir_cell1_bloc -> _ -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let MenhirCell1_bloc (_menhir_stack, _, _) = _menhir_stack in
      let MenhirCell1_expression (_menhir_stack, _, _) = _menhir_stack in
      let MenhirCell1_SI (_menhir_stack, _menhir_s) = _menhir_stack in
      let _v = _menhir_action_42 () in
      _menhir_goto_instruction _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_104 : type  ttv_stack. (((ttv_stack, _menhir_box_fichier) _menhir_cell1_SI, _menhir_box_fichier) _menhir_cell1_expression as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | SINON ->
          let _menhir_stack = MenhirCell1_bloc (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState105 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | ACCOUV ->
              _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | ACCFER | BOOLEEN _ | CHAR | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | OPMOINS | OPNON | OPPLUS | PAROUV | RETOUR | SI | TANTQUE | VIDE ->
          let MenhirCell1_expression (_menhir_stack, _, _) = _menhir_stack in
          let MenhirCell1_SI (_menhir_stack, _menhir_s) = _menhir_stack in
          let _v = _menhir_action_41 () in
          _menhir_goto_instruction _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_033 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_ACCOUV (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TYPEIDENT _ ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState033
      | STRING ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState033
      | INT ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState033
      | FLOAT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState033
      | CHAR ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState033
      | BOOL ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState033
      | ACCFER | BOOLEEN _ | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | OPMOINS | OPNON | OPPLUS | PAROUV | RETOUR | SI | TANTQUE | VIDE ->
          let _v = _menhir_action_72 () in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState033 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_034 : type  ttv_stack. ((ttv_stack, _menhir_box_fichier) _menhir_cell1_ACCOUV as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_variables (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TANTQUE ->
          _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState034
      | SI ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState034
      | RETOUR ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState034
      | PAROUV ->
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState034
      | OPPLUS ->
          _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState034
      | OPNON ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState034
      | OPMOINS ->
          _menhir_run_042 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState034
      | ACCFER ->
          let _ = _menhir_action_45 () in
          _menhir_run_110 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BOOLEEN _ | CHAR | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | VIDE ->
          let _v_1 = _menhir_action_69 () in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState034 _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_099 : type  ttv_stack. ((ttv_stack, _menhir_box_fichier) _menhir_cell1_TANTQUE, _menhir_box_fichier) _menhir_cell1_expression -> _ -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let MenhirCell1_expression (_menhir_stack, _, _) = _menhir_stack in
      let MenhirCell1_TANTQUE (_menhir_stack, _menhir_s) = _menhir_stack in
      let _v = _menhir_action_43 () in
      _menhir_goto_instruction _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_108 : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_RETOUR -> _ -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      match (_tok : MenhirBasics.token) with
      | PTVIRG ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_RETOUR (_menhir_stack, _menhir_s) = _menhir_stack in
          let _v = _menhir_action_44 () in
          _menhir_goto_instruction _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_102 : type  ttv_stack. ((ttv_stack, _menhir_box_fichier) _menhir_cell1_SI as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | PARFER ->
          let _menhir_s = MenhirState103 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | ACCOUV ->
              _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_097 : type  ttv_stack. ((ttv_stack, _menhir_box_fichier) _menhir_cell1_TANTQUE as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | PARFER ->
          let _menhir_s = MenhirState098 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | ACCOUV ->
              _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_094 : type  ttv_stack. ((ttv_stack, _menhir_box_fichier) _menhir_cell1_unairetoile _menhir_cell0_expr, _menhir_box_fichier) _menhir_cell1_binairetoile -> _ -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let MenhirCell1_binairetoile (_menhir_stack, _, _) = _menhir_stack in
      let MenhirCell0_expr (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_unairetoile (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _v = _menhir_action_31 () in
      _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_072 : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_CROOUV -> _ -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      match (_tok : MenhirBasics.token) with
      | CROFER ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_CROOUV (_menhir_stack, _menhir_s) = _menhir_stack in
          let _v = _menhir_action_53 () in
          _menhir_goto_suffixe _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_suffixe : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_suffixe (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | PAROUV ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState075
      | CROOUV ->
          _menhir_run_071 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState075
      | ASSIGN | BOOLEEN _ | CHAR | CROFER | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | OPDIV | OPEG | OPET | OPINF | OPINFEG | OPMOD | OPMOINS | OPMULT | OPNON | OPNONEG | OPOU | OPPLUS | OPPT | OPSUP | OPSUPEG | PARFER | PTVIRG | VIDE | VIRG ->
          let _ = _menhir_action_54 () in
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_064 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | PAROUV ->
          let _menhir_stack = MenhirCell1_PAROUV (_menhir_stack, _menhir_s) in
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState064
      | PARFER ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_51 () in
          _menhir_goto_suffixe _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | OPPLUS ->
          let _menhir_stack = MenhirCell1_PAROUV (_menhir_stack, _menhir_s) in
          _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState064
      | OPNON ->
          let _menhir_stack = MenhirCell1_PAROUV (_menhir_stack, _menhir_s) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState064
      | OPMOINS ->
          let _menhir_stack = MenhirCell1_PAROUV (_menhir_stack, _menhir_s) in
          _menhir_run_042 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState064
      | BOOLEEN _ | CHAR | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | VIDE ->
          let _menhir_stack = MenhirCell1_PAROUV (_menhir_stack, _menhir_s) in
          let _v = _menhir_action_69 () in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState064 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_071 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_CROOUV (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | PAROUV ->
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState071
      | OPPLUS ->
          _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState071
      | OPNON ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState071
      | OPMOINS ->
          _menhir_run_042 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState071
      | BOOLEEN _ | CHAR | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | VIDE ->
          let _v = _menhir_action_69 () in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState071 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_076 : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_suffixe -> _ -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let MenhirCell1_suffixe (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _ = _menhir_action_55 () in
      _menhir_goto_suffixetoile _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
  
  and _menhir_goto_suffixetoile : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok ->
      match _menhir_s with
      | MenhirState075 ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState063 ->
          _menhir_run_074 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_074 : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_unairetoile _menhir_cell0_exprouident -> _ -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let MenhirCell0_exprouident (_menhir_stack, _) = _menhir_stack in
      let _v = _menhir_action_29 () in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_068 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VIRG ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | PAROUV ->
              _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState069
          | OPPLUS ->
              _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState069
          | OPNON ->
              _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState069
          | OPMOINS ->
              _menhir_run_042 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState069
          | BOOLEEN _ | CHAR | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | VIDE ->
              let _v_0 = _menhir_action_69 () in
              _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState069 _tok
          | _ ->
              _eRR ())
      | PARFER ->
          let _ = _menhir_action_36 () in
          _menhir_goto_exprvirg _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_exprvirg : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      match _menhir_s with
      | MenhirState069 ->
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MenhirState064 ->
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_070 : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_expression -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let MenhirCell1_expression (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _ = _menhir_action_37 () in
      _menhir_goto_exprvirg _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
  
  and _menhir_run_066 : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_PAROUV -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_PAROUV (_menhir_stack, _menhir_s) = _menhir_stack in
      let _v = _menhir_action_52 () in
      _menhir_goto_suffixe _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_055 : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_unairetoile _menhir_cell0_IDENT -> _ -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      match (_tok : MenhirBasics.token) with
      | CROFER ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _ = _menhir_action_35 () in
          _menhir_goto_exprourien _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_exprourien : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_unairetoile _menhir_cell0_IDENT -> _ -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let MenhirCell0_IDENT (_menhir_stack, _) = _menhir_stack in
      let _v = _menhir_action_28 () in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_048 : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_unairetoile -> _ -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      match (_tok : MenhirBasics.token) with
      | PARFER ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_33 () in
          _menhir_goto_exprouident _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_exprouident : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_unairetoile -> _ -> _ -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _menhir_stack = MenhirCell0_exprouident (_menhir_stack, _v) in
      match (_tok : MenhirBasics.token) with
      | PAROUV ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState063
      | CROOUV ->
          _menhir_run_071 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState063
      | ASSIGN | BOOLEEN _ | CHAR | CROFER | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | OPDIV | OPEG | OPET | OPINF | OPINFEG | OPMOD | OPMOINS | OPMULT | OPNON | OPNONEG | OPOU | OPPLUS | OPPT | OPSUP | OPSUPEG | PARFER | PTVIRG | VIDE | VIRG ->
          let _ = _menhir_action_54 () in
          _menhir_run_074 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_016 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_typeBase (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | CROOUV ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | CROFER ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _ = _menhir_action_20 () in
              _menhir_goto_declTab _menhir_stack _menhir_lexbuf _menhir_lexer _tok
          | _ ->
              _eRR ())
      | IDENT _ ->
          let _ = _menhir_action_19 () in
          _menhir_goto_declTab _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_declTab : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_typeBase -> _ -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let MenhirCell1_typeBase (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _v = _menhir_action_64 () in
      _menhir_goto_typeStruct _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_typeStruct : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState033 ->
          _menhir_run_118 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
      | MenhirState116 ->
          _menhir_run_118 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
      | MenhirState030 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState000 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState012 ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState025 ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState003 ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_118 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | IDENT _ ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | PTVIRG ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_71 () in
              let _menhir_stack = MenhirCell1_variable (_menhir_stack, _menhir_s, _v) in
              (match (_tok : MenhirBasics.token) with
              | TYPEIDENT _ ->
                  _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState116
              | STRING ->
                  _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState116
              | INT ->
                  _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState116
              | FLOAT ->
                  _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState116
              | CHAR ->
                  _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState116
              | BOOL ->
                  _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState116
              | ACCFER | BOOLEEN _ | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | OPMOINS | OPNON | OPPLUS | PAROUV | RETOUR | SI | TANTQUE | VIDE ->
                  let _v_1 = _menhir_action_72 () in
                  _menhir_run_117 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 _tok
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_117 : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_variable -> _ -> _ -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_variable (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _2 = _v in
      let _v = _menhir_action_73 _2 in
      _menhir_goto_variables _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_variables : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState116 ->
          _menhir_run_117 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState033 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_023 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
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
                  _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState025
              | STRING ->
                  _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState025
              | INT ->
                  _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState025
              | FLOAT ->
                  _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState025
              | CHAR ->
                  _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState025
              | BOOL ->
                  _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState025
              | PARFER ->
                  let _ = _menhir_action_47 () in
                  _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_026 : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_typeStruct _menhir_cell0_IDENT -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell0_IDENT (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_typeStruct (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _v = _menhir_action_21 () in
      _menhir_goto_entete _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_entete : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_entete (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | ACCOUV ->
          _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState032
      | _ ->
          _eRR ()
  
  and _menhir_run_013 : type  ttv_stack. (((ttv_stack, _menhir_box_fichier) _menhir_cell1_typeStruct _menhir_cell0_IDENT, _menhir_box_fichier) _menhir_cell1_VIRG as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_typeStruct (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | IDENT _v_0 ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v_0) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VIRG ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState014
          | PARFER ->
              let _ = _menhir_action_56 () in
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_012 : type  ttv_stack. ((ttv_stack, _menhir_box_fichier) _menhir_cell1_typeStruct _menhir_cell0_IDENT as 'stack) -> _ -> _ -> ('stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_VIRG (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState012 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TYPEIDENT _ ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FLOAT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | CHAR ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_015 : type  ttv_stack. (((ttv_stack, _menhir_box_fichier) _menhir_cell1_typeStruct _menhir_cell0_IDENT, _menhir_box_fichier) _menhir_cell1_VIRG, _menhir_box_fichier) _menhir_cell1_typeStruct _menhir_cell0_IDENT -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let MenhirCell0_IDENT (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_typeStruct (_menhir_stack, _, _) = _menhir_stack in
      let MenhirCell1_VIRG (_menhir_stack, _menhir_s) = _menhir_stack in
      let _ = _menhir_action_57 () in
      _menhir_goto_suiteParsFormels _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
  
  and _menhir_goto_suiteParsFormels : type  ttv_stack. ((ttv_stack, _menhir_box_fichier) _menhir_cell1_typeStruct _menhir_cell0_IDENT as 'stack) -> _ -> _ -> ('stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      match _menhir_s with
      | MenhirState011 ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MenhirState014 ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_020 : type  ttv_stack. (ttv_stack _menhir_cell0_IDENT, _menhir_box_fichier) _menhir_cell1_typeStruct _menhir_cell0_IDENT -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let MenhirCell0_IDENT (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_typeStruct (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _ = _menhir_action_48 () in
      _menhir_goto_parsFormels _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
  
  and _menhir_goto_parsFormels : type  ttv_stack. (ttv_stack _menhir_cell0_IDENT as 'stack) -> _ -> _ -> ('stack, _menhir_box_fichier) _menhir_state -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      match _menhir_s with
      | MenhirState025 ->
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MenhirState003 ->
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_021 : type  ttv_stack. (ttv_stack, _menhir_box_fichier) _menhir_cell1_VOID _menhir_cell0_IDENT -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell0_IDENT (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_VOID (_menhir_stack, _menhir_s) = _menhir_stack in
      let _v = _menhir_action_22 () in
      _menhir_goto_entete _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_010 : type  ttv_stack. (ttv_stack _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_fichier) _menhir_state -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_typeStruct (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | IDENT _v_0 ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v_0) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VIRG ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState011
          | PARFER ->
              let _ = _menhir_action_56 () in
              _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  let _menhir_run_000 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_fichier =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | VOID ->
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | TYPEIDENT _ ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | STRING ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | INT ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | FLOAT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | CHAR ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | BOOL ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | FIN ->
          let _ = _menhir_action_49 () in
          _menhir_run_028 _menhir_stack
      | _ ->
          _eRR ()
  
end

let fichier =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_fichier v = _menhir_run_000 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v

# 175 "parserJava.mly"
  

# 2319 "parserJava.ml"
