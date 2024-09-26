# regex simplifiées

## Entiers

### Binaires

```ocaml
let binaryDigit = '0'|'1' (* chiffre de base *)
let binaryDigitOrUnderscore = '0'|'1'|'_' (* chiffre ou _ *)
let binaryDigitsAndUnderscores = ('0'|'1'|'_')+ (* chiffres + _ *)
let binaryDigits = ('0'|'1') | ('0'|'1') ('0'|'1'|'_')* ('0'|'1') (* chiffres accolés *)
let binaryNumeral = '0' ('b'|'B') (('0'|'1') | ('0'|'1') ('0'|'1'|'_')* ('0'|'1')) (* nombre complet: 0b ou 0B suivi de chiffres binaires *)
```

### Octaux

```ocaml
let octalDigit = ['0'-'7'] (* chiffre de base *)
let octalDigitOrUnderscore = ['0'-'7']|'_' (* chiffre ou _ *)
let octalDigitsAndUnderscores = (['0'-'7']|'_')+ (* chiffres + _ *)
let octalDigits = ['0'-'7'] | ['0'-'7'] (['0'-'7']|'_')* ['0'-'7'] (* chiffres accolés *)
let octalNumeral = '0' ['0'-'7'] | ['0'-'7'] (['0'-'7']|'_')* ['0'-'7'] (* nombre complet: 0 suivi de chiffres octaux *)
```

### Hexadécimaux

```ocaml
let hexDigit = ['0'-'9' 'a'-'f' 'A'-'F'] (* chiffre de base *)
let hexDigitOrUnderscore = ['0'-'9' 'a'-'f' 'A'-'F']|'_' (* chiffre ou _ *)
let hexDigitsAndUnderscores = (['0'-'9' 'a'-'f' 'A'-'F']|'_')+ (* chiffres + _ *)
let hexDigits = ['0'-'9' 'a'-'f' 'A'-'F'] | ['0'-'9' 'a'-'f' 'A'-'F'] (['0'-'9' 'a'-'f' 'A'-'F']|'_')* ['0'-'9' 'a'-'f' 'A'-'F'] (* chiffres accolés *)
let hexNumeral = '0' ('x'|'X') (['0'-'9' 'a'-'f' 'A'-'F'] | ['0'-'9' 'a'-'f' 'A'-'F'] (['0'-'9' 'a'-'f' 'A'-'F']|'_')* ['0'-'9' 'a'-'f' 'A'-'F']) (* nombre complet: 0x ou 0X suivi de chiffres hexadécimaux *)
```
