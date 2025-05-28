# Sémantique & TDL - TP 2

## Commandes

Pour build le projet:

```bash
dune build
```

Pour interpréter un programme MiniML:

```bash
dune exec ./Main.exe <fichier>
```

Pour lancer les tests:

```bash
dune runtest
```

## TODO

Le but de ce TP est d'introduire dans l'interprete du TP2, les aspects impératifs du MiniML (reference, affectation, séquence d'instructions) ainsi que le typage des expressions.

- [x] Dans un premier temps, voir comment la notion de mémoire a été rajoutée à la solution fournie du TP précédent. Les règles d'inférence sans mémoire sont dans [`regles-sans-effet-de-bord.pdf`](regles-sans-effet-de-bord.pdf) et avec mémoire dans [`regles-avec-effet-de-bord.pdf`](regles-avec-effet-de-bord.pdf), et le code Caml dans [`Semantics.ml`](Semantics.ml). Bien sûr, dans cette version, les aspects impératifs n'ont pas été implantés.
- [x] Implanter les règles des aspects impératifs en complétant le fichier [`Semantics.ml`](Semantics.ml). Tester.
- [x] Implanter les règles de typage vues en TD et rappelées dans le  fichier [`regles-typage.pdf`](regles-typage.pdf), en complétant le fichier [`Types.ml`](Types.ml) et en décommentant l'appel au typage dans le [`Main.ml`](Main.ml)
