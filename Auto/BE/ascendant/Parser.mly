%{

(* Partie recopiee dans le fichier CaML genere. *)
(* Ouverture de modules exploites dans les actions *)
(* Declarations de types, de constantes, de fonctions, d'exceptions exploites dans les actions *)

%}

/* Declaration des unites lexicales et de leur type si une valeur particuliere leur est associee */

(* A COMPLETER *)
%token <string> IDENT
%token PAROUV PARFER
%token POINT

/* Defini le type des donnees associees a l'unite lexicale */

(* A COMPLETER *)
%token <int> ENTIER

/* Unite lexicale particuliere qui represente la fin du fichier */

%token UL_FIN

/* Type renvoye pour le nom terminal document */
%type <unit> scheme

/* Le non terminal document est l'axiome */
%start scheme

%% /* Regles de productions */

scheme : s_expression UL_FIN { (print_endline "scheme : expression UL_FIN ") }

s_expression : PAROUV expression PARFER { (print_endline "expr_par")}
           | IDENT {(print_endline "expr: IDENT")}
           | ENTIER { (print_endline "expr: ENTIER") }

expression : s_expression POINT s_expression { (print_endline "expr point")}
            | s_expression* {(print_endline "expr étoile")}

%%
