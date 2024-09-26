{

  open TokenJava
(*  open String *)
(*  open Str *)
  exception LexicalError

}

(* Macro-definitions *)
let minuscule = ['a'-'z']
let majuscule = ['A'-'Z']
let chiffre = ['0'-'9']
let alphabet = minuscule | majuscule
let alphanum = alphabet | chiffre | '_'
let commentaireBloc = "/*" ([^'*'] | '*'[^'/'])* "*/" (* Soit [pas étoile], soit [étoile puis pas slash] *)
let commentaireLigne = "//" [^'\n']* '\n'

(* entiers binaires *) (*
let binaryDigit = '0' | '1' (* chiffre de base *)
let binaryDigitOrUnderscore = binaryDigit|'_' (* chiffre ou _ *)
let binaryDigitsAndUnderscores = binaryDigitOrUnderscore+ (* chiffres + _ *)
let binaryDigits = binaryDigit | binaryDigit binaryDigitsAndUnderscores? binaryDigit (* chiffres accolés *)
let binaryNumeral = '0' ('b'|'B') binaryDigits (* nombre complet: 0b ou 0B suivi de chiffres binaires *)
*)
let binaryNumeral = '0' ('b'|'B') (('0'|'1') | ('0'|'1') ('0'|'1'|'_')* ('0'|'1'))

(* entiers octaux *) (*
let octalDigit = ['0'-'7'] (* chiffre de base *)
let octalDigitOrUnderscore = octalDigit|'_' (* chiffre ou _ *)
let octalDigitsAndUnderscores = octalDigitOrUnderscore+ (* chiffres + _ *)
let octalDigits = octalDigit | octalDigit octalDigitsAndUnderscores? octalDigit (* chiffres accolés *)
let octalNumeral = '0' octalDigits (* nombre complet: 0 suivi de chiffres octaux *)
*)
let octalNumeral = '0' ['0'-'7'] | ['0'-'7'] (['0'-'7']|'_')* ['0'-'7']

(* entiers hexadécimaux *) (*
let hexDigit = ['0'-'9' 'a'-'f' 'A'-'F'] (* chiffre de base *)
let hexDigitOrUnderscore = hexDigit|'_' (* chiffre ou _ *)
let hexDigitsAndUnderscores = hexDigitOrUnderscore+ (* chiffres + _ *)
let hexDigits = hexDigit | hexDigit hexDigitsAndUnderscores? hexDigit (* chiffres accolés *)
let hexNumeral = '0' ('x'|'X') hexDigits (* nombre complet: 0x ou 0X suivi de chiffres hexadécimaux *)
*)
let hexNumeral = '0' ('x'|'X') (['0'-'9' 'a'-'f' 'A'-'F'] | ['0'-'9' 'a'-'f' 'A'-'F'] (['0'-'9' 'a'-'f' 'A'-'F']|'_')* ['0'-'9' 'a'-'f' 'A'-'F'])

(* entiers décimaux *)
let underscores = '_'+ (* séparateurs _ *)
let nonZeroDigit = ['1'-'9'] (* chiffre de base (sans 0) *)
let digit = '0' | nonZeroDigit (* chiffre de base *)
let digitOrUnderscore = digit|'_' (* chiffre ou _ *)
let digitsAndUnderscores = digitOrUnderscore+ (* chiffres + _ *)
let digits = digit | digit digitsAndUnderscores? digit (* chiffres accolés *)
let decimalNumeral = '0' | nonZeroDigit digits? | nonZeroDigit underscores digits (* nombre complet: 0 ou chiffre non nul suivi de chiffres décimaux *)

(* litéraux entiers *)
let integerTypeSuffix = 'l' | 'L'
let integerLiteral = (decimalNumeral | hexNumeral | octalNumeral | binaryNumeral) integerTypeSuffix?

(* littéraux flottants décimaux *)
let floatTypeSuffix = 'f' | 'F' | 'd' | 'D'
let sign = '+' | '-'
let signedInteger = sign? digits
let exponentIndicator = 'e' | 'E'
let exponentPart = exponentIndicator signedInteger
let decimalFloatingPointLiteral = digits '.' digits? exponentPart? floatTypeSuffix?
                                       | '.' digits exponentPart? floatTypeSuffix?
                                       |     digits exponentPart floatTypeSuffix?
                                       |     digits exponentPart? floatTypeSuffix

(* littéraux flottants hexadécimaux *)
let binaryExponentIndicator = 'p' | 'P'
let binaryExponent = binaryExponentIndicator signedInteger
let hexSignificand = hexNumeral '.'? | '0' ('x'|'X') hexDigits? '.' hexDigits
let hexFloatingPointLiteral = hexSignificand binaryExponent floatTypeSuffix?

(* littéraux flottants *)
let floatingPointLiteral = decimalFloatingPointLiteral | hexFloatingPointLiteral

(* Analyseur lexical : expression reguliere { action CaML } *)
rule lexer = parse
(* Espace, tabulation, passage a ligne, etc : consommes par l'analyse lexicale *)
  | ['\n' '\t' ' ']+    { lexer lexbuf }
(* Commentaires consommes par l'analyse lexicale *)
  | commentaireBloc  	{ lexer lexbuf }
  | commentaireLigne	{ lexer lexbuf }
(* Structures de blocs *)
  | "("                 { PAROUV }
  | ")"                 { PARFER }
  | "["                 { CROOUV }
  | "]"                 { CROFER }
  | "{"                 { ACCOUV }
  | "}"                 { ACCFER }
(* Separateurs *)
  | ","                 { VIRG }
  | ";"                 { PTVIRG }
(* Operateurs booleens *)
  | "||"                { OPOU }
  | "&&"                { OPET }
  | "!"                 { OPNON }
(* Operateurs comparaisons *)
  | "=="                { OPEG }
  | "!="                { OPNONEG }
  | "<="                { OPSUPEG }
  | "<"                 { OPSUP }
  | ">="                { OPINFEG }
  | ">"                 { OPINF }
(* Operateurs arithmetiques *)
  | "+"                 { OPPLUS }
  | "-"                 { OPMOINS }
  | "*"                 { OPMULT }
  | "/"                 { OPDIV }
  | "%"                 { OPMOD }
  | "."                 { OPPT }
  | "="                 { ASSIGN }
  | "new"               { NOUVEAU }
(* Mots cles : types *)
  | "bool"              { BOOL }
  | "char"              { CHAR }
  | "float"             { FLOAT }
  | "int"               { INT }
  | "String"            { STRING }
  | "void"              { VOID }
(* Mots cles : instructions *)
  | "while"		{ TANTQUE }
  | "if"		{ SI }
  | "else"		{ SINON }
  | "return"		{ RETOUR }
(* Mots cles : constantes *)
  | "true"		{ (BOOLEEN true) }
  | "false"		{ (BOOLEEN false) }
  | "null"		{ VIDE }
(* Nombres entiers : TODO *)
  | integerLiteral as texte   { (ENTIER (int_of_string texte)) }
(* Nombres flottants : TODO *)
  | floatingPointLiteral as texte     { (FLOTTANT (float_of_string texte)) }
(* Caracteres : TODO *)
  | "'" _ "'" as texte                   { CARACTERE texte.[1] }
(* Chaines de caracteres : TODO *)
  | '"' _* '"' as texte                  { CHAINE texte }
(* Identificateurs *)
  | majuscule alphanum* as texte              { TYPEIDENT texte }
  | minuscule alphanum* as texte              { IDENT texte }
  | eof                                       { FIN }
  | _                                         { raise LexicalError }

{

}
