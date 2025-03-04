# L'exclusion avec jeton circulant

## Commandes

Pour générer un fichier `.pdf` à partir du fichier `.tla` :

```bash
java -classpath /mnt/n7fs/tla/tla2tools.jar tla2tex.TLA -latexCommand pdflatex -shade jeton.tla
```

Pour vérifier le fichier

```bash
java -classpath /mnt/n7fs/tla/tla2tools.jar tlc2.TLC jeton
```

## Objectif

Étudier en détail le jeton circulant

## Inspiration

Une solution partielle de l'exclusion mutuelle à base d'un
jeton circulant, vu en TD. Il s'agit d'une solution basique qui assure
l'exclusion mutuelle mais n'assure ni la vivacité de la circulation du
jeton, ni la vivacité d'obtention de l'accès exclusif.

## Questions

1. Énoncer les propriétés attendues pour le protocole : `ExclMutuelle`; `VivaciteIndividuelle`, `VivaciteGlobale` ; pour le jeton : `JetonVaPartout`; pour le lien jeton-protocole : `Sanity`.
2. Avec quelles contraintes d'équité *forte* est-il possible de vérifier `VivaciteIndividuelle` ?
3. Donner une solution qui ne nécessite que de l'équité *faible*.
4. Scinder la variable entière `jeton` en un tableau de N booléens. Le déplacement du jeton est encore atomique. Énoncer soigneusement les propriétés attendues pour le jeton (par exemple l'unicité).
5. Démontrer que cette version est un raffinage de la version précédente. En particulier, énoncer proprement le mapping entre les variables des deux modules.
6. Rendre non atomique le déplacement du jeton : on introduit un canal de communication entre chaque couple de sites `i` et `i+1`. La précédent action de transmission devient deux actions : une action d'envoi du jeton (ajout dans le canal) et une action de réception du jeton (extraction du canal).   Pour représenter un canal, un modèle simple est la séquence de booléens.   Bien penser à spécifier les propriétés attendues (par exemple : au plus un canal non vide).
7. Démontrer que cette version est un raffinage de la version précédente. On prendra soin au mapping.

## Réponses

1. Voir le fichier [`jeton.tla`](jeton.tla)
2. L'équité *forte* est nécessaire sur `entrer` et `bouger` sinon, les processus attendent indéfiniement. Il faut aussi une équité *faible* sur `sortir` pour qu'un processus ne bloque pas l'accès.
3. Il y a deux modifications à faire:
   - faire "passer" le jeton par un programme sortant : enlève `SF(bouger(i))` car le jeton circulera toujours (pas bloqué).
   - vérifier qu'un processus n'est pas demandeur avant de lui retirer son jeton : enlève `SF(entrer(i))` car on évite de lui faire passer son jeton sous le nez.
4. Voir le fichier [`jeton2.tla`](jeton2.tla). Il faut rajouter une propriété d'unicité du jeton.
5. hop hop hop on saute la question discrètement.
