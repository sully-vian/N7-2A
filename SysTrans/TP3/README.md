# Le problème des philosophes

## Objectif

Étudier le problème des philosophes

## Rappel

Les philosophes sont organisés circulairement autour d'une
table. Entre chaque assiette se trouve une fourchette. Un philosophe peut
manger quand il a les deux fourchettes adjacentes à son assiette. En
s'abstrayant des fourchettes, il est équivalent de dire que deux philosophes
voisins ne peuvent jamais manger simultanément.

## Modélisation abstraite (sans les fourchettes) -- squelette fourni --

1. Quelles sont les variables d'états nécessaires ?
2. Quelle est la spécification, ie quelles sont les propriétés temporelles attendues (invariant, leadsto, etc) ?
3. Écrire une modélisation (un "programme") correspondant à l'énoncé.
4. Quelles sont les contraintes d'équité nécessaires (WF et SF) ?
5. Vérifier que votre programme valide/invalide les propriétés attendues.

### Réponses 1

1. La seule variable d'état nécessaire est `etat` qui représente l'état de chaque philosophe.
2. Les propriétés temporelles sont les suivantes:
   - La propriété d'**exclusion mutuelle**: <br>
  $\square (\forall i \in \text{Philos} : \text{etat}[i] = \text{E} \Rightarrow (\text{etat}[gauche(i)] \neq \text{E}) \land (\text{etat}[gauche(i)] \neq \text{E}))$ \
   - La propriété de **vivacité individuelle**: <br>
   $\forall i \in \text{Philos} :  \text{etat}[i] = \text{H} \leadsto \text{etat}[i] = \text{E}$
   - La proprité de **vivacité globale**: <br>
   $(\exist i \in \text{Philos} : \text{etat}[i] = \text{H}) \leadsto (\exist j \in \text{Philos} : \text{etat}[j] = \text{E})$
3. voir [`philosophes0.tla`](philosophes0.tla)
4. `manger` nécessite une équité faible pour éviter qu'un philosophe ne décide d'attendre indéfiniemment de manger. `penser` nécessite une équité forte pour éviter qu'un philosophe bloque les autres indéfiniement.
5. Même avec une triple équité forte, il existe toujours un scénario où un philosophe attend indéfiniement (retour à l'état 4):
   $$ T,T,T \rightarrow T,H,T \rightarrow H,H,T \rightarrow E,H,T \rightarrow E,H,H \rightarrow E,H,E \rightarrow T,H,E \rightarrow H,H,E \rightarrow E,H,E \rightarrow E,H,T $$

## Avec fourchettes (sans ordre de prise)

1. Quelles sont les variables d'état supplémentaires ?
2. Y a-t-il de nouvelles propriétés temporelles ? (au moins celles liant les nouvelles variables d'états aux anciennes).
3. Montrer alors la possibilité d'interblocage.

### Réponses 2

1. Il nous faut une variable `forks` qui indique l'état de chaque fourchette: utilisée par le philosophe de gauche, de droite ou inutilisée (sur la table).
2. 

## Avec fourchettes et ordre de prise

1. Quelles sont les contraintes d'équité nécessaires pour obtenir les propriétés de vivacité attendues ?
2. Trouver une solution qui ne nécessite que de l'équité faible.

### Réponses 3
