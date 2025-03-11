# TPs de Systèmes de Transition

## Commandes

Pour générer un fichier `.pdf` à partir du fichier `.tla` :

```bash
java -classpath /mnt/n7fs/tla/tla2tools.jar tla2tex.TLA -latexCommand pdflatex -shade module.tla
```

Pour vérifier le fichier

```bash
java -classpath /mnt/n7fs/tla/tla2tools.jar tlc2.TLC module
```
