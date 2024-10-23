# Résultats

## max

Tableau généré avec `java LargIntArray -g foo 1000000 1000`

`java MaxTabSequential foo 20` - 609 µs

`java MaxTabThread foo 20 4` - 1324 µs

`java MaxTabPool foo 20 4 8` - 434 µs

`java MaxTabForkJoin foo 20 1000` 866 µs
