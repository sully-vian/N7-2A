# Métaprogrammation & Tests - TP2 - JUnit et introspection

## Exercice 1 : La classe `Lanceur`

1. On préfèrera `getMethod` et `getMethods` car eles permettent de récupérer toutes les méthodes applicables sur une classe, incluent celles des classes dot elle hérite.
2. Dans le cas où le test ne définit pas de méthode `nettoyer`, il faut s'assurer que les objets utilisés dans plusieurs tests soient dans le même état au début de chaque test (objets immuables, ou déclaration locale dans chaque méthode de test). De même dans le cas où le test ne définit pas de méthode `préparer`.
3. Voir le code
4. Idem
5. Ce choix a été fait pour éviter à la classe lançant les tests d'avoir à considérer les cas d'inexistance des méthodes `preparer` et `nettoyer`. De plus, on peut alors insatncier directement la classe de test avec le type `TestCase` plutôt qu'`Object`.

## Exercice 2 : Tester le Lanceur

> enfer de la programmation réflexive
