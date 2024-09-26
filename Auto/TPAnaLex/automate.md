# Regex simplifiées

## Entiers

### Entiers binaires

```ocaml
let binaryDigit = '0'|'1' (* chiffre de base *)
let binaryDigitOrUnderscore = '0'|'1'|'_' (* chiffre ou _ *)
let binaryDigitsAndUnderscores = ('0'|'1'|'_')+ (* chiffres + _ *)
let binaryDigits = ('0'|'1') | ('0'|'1') ('0'|'1'|'_')* ('0'|'1') (* chiffres accolés *)
let binaryNumeral = '0' ('b'|'B') (('0'|'1') | ('0'|'1') ('0'|'1'|'_')* ('0'|'1')) (* nombre complet: 0b ou 0B suivi de chiffres binaires *)
```

### Entiers octaux

```ocaml
let octalDigit = ['0'-'7'] (* chiffre de base *)
let octalDigitOrUnderscore = ['0'-'7']|'_' (* chiffre ou _ *)
let octalDigitsAndUnderscores = (['0'-'7']|'_')+ (* chiffres + _ *)
let octalDigits = ['0'-'7'] | ['0'-'7'] (['0'-'7']|'_')* ['0'-'7'] (* chiffres accolés *)
let octalNumeral = '0' (['0'-'7'] | ['0'-'7'] (['0'-'7']|'_')* ['0'-'7']) (* nombre complet: 0 suivi de chiffres octaux *)
```

### Entiers hexadécimaux

```ocaml
let hexDigit = ['0'-'9' 'a'-'f' 'A'-'F'] (* chiffre de base *)
let hexDigitOrUnderscore = ['0'-'9' 'a'-'f' 'A'-'F']|'_' (* chiffre ou _ *)
let hexDigitsAndUnderscores = (['0'-'9' 'a'-'f' 'A'-'F']|'_')+ (* chiffres + _ *)
let hexDigits = ['0'-'9' 'a'-'f' 'A'-'F'] | ['0'-'9' 'a'-'f' 'A'-'F'] (['0'-'9' 'a'-'f' 'A'-'F']|'_')* ['0'-'9' 'a'-'f' 'A'-'F'] (* chiffres accolés *)
let hexNumeral = '0' ('x'|'X') (['0'-'9' 'a'-'f' 'A'-'F'] | ['0'-'9' 'a'-'f' 'A'-'F'] (['0'-'9' 'a'-'f' 'A'-'F']|'_')* ['0'-'9' 'a'-'f' 'A'-'F']) (* nombre complet: 0x ou 0X suivi de chiffres hexadécimaux *)
```

### Entiers Décimaux

```ocaml
let underscores = '_'+ (* séparateurs _ *)
let nonZeroDigit = ['1'-'9'] (* chiffre de base (sans 0) *)
let digit = ['0'-'9'] (* chiffre de base *)
let digitOrUnderscore = ['0'-'9']|'_' (* chiffre ou _ *)
let digitsAndUnderscores = (['0'-'9']|'_')+ (* chiffres + _ *)
let digits = ['0'-'9'] | ['0'-'9'] (['0'-'9']|'_')* ['0'-'9'] (* chiffres accolés *)
let decimalNumeral = '0' | ['1'-'9'] (['0'-'9'] | ['0'-'9'] (['0'-'9']|'_')* ['0'-'9'])? | ['1'-'9'] '_'+ (['0'-'9'] | ['0'-'9'] (['0'-'9']|'_')* ['0'-'9']) (* nombre complet: 0 ou chiffre non nul suivi de chiffres décimaux *)
```

## Flottants

### flottants hexadécimaux

```ocaml
let binaryExponentIndicator = 'p' | 'P'
let binaryExponent = ('p' | 'P') sign? (['0'-'9'] | ['0'-'9'] (['0'-'9']|'_')* ['0'-'9'])
let hexSignificand = hexNumeral '.'? | '0' ('x'|'X') (['0'-'9' 'a'-'f' 'A'-'F'] | ['0'-'9' 'a'-'f' 'A'-'F'] (['0'-'9' 'a'-'f' 'A'-'F']|'_')* ['0'-'9' 'a'-'f' 'A'-'F'])? '.' (['0'-'9' 'a'-'f' 'A'-'F'] | ['0'-'9' 'a'-'f' 'A'-'F'] (['0'-'9' 'a'-'f' 'A'-'F']|'_')* ['0'-'9' 'a'-'f' 'A'-'F'])
let hexFloatingPointLiteral = (hexNumeral '.'? | '0' ('x'|'X') (['0'-'9' 'a'-'f' 'A'-'F'] | ['0'-'9' 'a'-'f' 'A'-'F'] (['0'-'9' 'a'-'f' 'A'-'F']|'_')* ['0'-'9' 'a'-'f' 'A'-'F'])? '.' (['0'-'9' 'a'-'f' 'A'-'F'] | ['0'-'9' 'a'-'f' 'A'-'F'] (['0'-'9' 'a'-'f' 'A'-'F']|'_')* ['0'-'9' 'a'-'f' 'A'-'F'])) ('p' | 'P') sign? (['0'-'9'] | ['0'-'9'] (['0'-'9']|'_')* ['0'-'9']) floatTypeSuffix?
```

### flottants décimaux

```ocaml
let floatTypeSuffix = 'f' | 'F' | 'd' | 'D'
let sign = '+' | '-'
let signedInteger = sign? (['0'-'9'] | ['0'-'9'] (['0'-'9']|'_')* ['0'-'9'])
let exponentIndicator = 'e' | 'E'
let exponentPart = ('e' | 'E') sign? (['0'-'9'] | ['0'-'9'] (['0'-'9']|'_')* ['0'-'9'])
let decimalFloatingPointLiteral1 = (['0'-'9'] | ['0'-'9'] (['0'-'9']|'_')* ['0'-'9']) '.' (['0'-'9'] | ['0'-'9'] (['0'-'9']|'_')* ['0'-'9'])? (('e' | 'E') sign? (['0'-'9'] | ['0'-'9'] (['0'-'9']|'_')* ['0'-'9']))? floatTypeSuffix?
let decimalFloatingPointLiteral2 = '.' (['0'-'9'] | ['0'-'9'] (['0'-'9']|'_')* ['0'-'9']) (('e' | 'E') sign? (['0'-'9'] | ['0'-'9'] (['0'-'9']|'_')* ['0'-'9']))? floatTypeSuffix?
let decimalFloatingPointLiteral3 = (['0'-'9'] | ['0'-'9'] (['0'-'9']|'_')* ['0'-'9']) ('e' | 'E') sign? (['0'-'9'] | ['0'-'9'] (['0'-'9']|'_')* ['0'-'9']) floatTypeSuffix?
let decimalFloatingPointLiteral4 = (['0'-'9'] | ['0'-'9'] (['0'-'9']|'_')* ['0'-'9']) (('e' | 'E') sign? (['0'-'9'] | ['0'-'9'] (['0'-'9']|'_')* ['0'-'9']))? floatTypeSuffix
let decimalFloatingPointLiteral = decimalFloatingPointLiteral1
                                | decimalFloatingPointLiteral2
                                | decimalFloatingPointLiteral3
                                | decimalFloatingPointLiteral4
```

## Caractères

```ocaml
let octalEscape = "\\" ['0'-'7']
                | "\\" ['0'-'7'] ['0'-'7']
                | "\\" ['0'-'3'] ['0'-'7'] ['0'-'7']
let escapeSequence = "\b" | "\t" | "\n" | "\f" | "\r" | "\"" | "'" | "\\" | ("\\" ['0'-'7'] | "\\" ['0'-'7'] ['0'-'7'] | "\\" ['0'-'3'] ['0'-'7'] ['0'-'7'])
let rawInputCharacter = _ (* n'importe quel caractère unicode *)
let unicodeMarker = 'u'+
let unicodeEscape = '\\' 'u'+ hexDigit hexDigit hexDigit hexDigit
let unicodeInputCharacter = ('\\' 'u'+ hexDigit hexDigit hexDigit hexDigit) | _
let inputCharacter = unicodeInputCharacter - ['\r' '\n']
let singleCharacter = inputCharacter - ['\'' '\\']
let characterLiteral = "'" (('\\' 'u'+ ['0'-'7'] ['0'-'7'] ['0'-'7'] ['0'-'7']) | [^'\r' '\n' '\'' '\\']) "'"
                      | "'" ("\b" | "\t" | "\n" | "\f" | "\r" | "\"" | "'" | "\\" | ("\\" ['0'-'7'] | "\\" ['0'-'7'] ['0'-'7'] | "\\" ['0'-'3'] ['0'-'7'] ['0'-'7'])) "'"
```

## Chaînes de caractères

```ocaml
let stringCharacter = (('\\' 'u'+ ['0'-'7'] ['0'-'7'] ['0'-'7'] ['0'-'7']) | [^'\r' '\n' '\'' '\\'])
                    | ("\b" | "\t" | "\n" | "\f" | "\r" | "\"" | "'" | "\\" | ("\\" ['0'-'7'] | "\\" ['0'-'7'] ['0'-'7'] | "\\" ['0'-'3'] ['0'-'7'] ['0'-'7']))
let stringLiteral = "\"" ((('\\' 'u'+ ['0'-'7'] ['0'-'7'] ['0'-'7'] ['0'-'7']) | [^'\r' '\n' '\'' '\\']) | ("\b" | "\t" | "\n" | "\f" | "\r" | "\"" | "'" | "\\" | ("\\" ['0'-'7'] | "\\" ['0'-'7'] ['0'-'7'] | "\\" ['0'-'3'] ['0'-'7'] ['0'-'7'])))* "\""
```
