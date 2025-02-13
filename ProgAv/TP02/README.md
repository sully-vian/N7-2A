# Programmation Avancée - TP1: Inversion de contrôle

## Exercice 1: Point de départ

voir code

## Exercice 2: Évolution: Plusieurs fichiers

voir code

## Exercice 3: Évolution: Cohérence du fichier

voir code

## Exercice 4: Évolution: Autre format du fichier

voir code

## Exercice 5: Évolution: Nouvelle Architecture

1. L'architecture originale est verbeuse, il faut créer une fonction différente par format. La gestion des exceptions pour changer de format est également verbeuse. Il n'est pas envisageable de faire une seule méthode `charger` car elle serait trop longue et difficile à maintenir.
2. Il faudrait créer une classe d'analyseur pour chaque format. Ces classes hériteraient toutes d'une même classe abstraite `Analyseur` définissant les méthodes `valeur` et `donnees` ainsi que la signature de la méthode `format` spécifique à chaque format
3. flemme.
