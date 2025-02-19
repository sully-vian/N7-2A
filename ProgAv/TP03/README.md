# TP3 - Proxy

## Exercice 1 - Comprendre unmodifiableList

1. L'exception `java.lang.UnsupportedOperationException` est levée lorsqu'on tente de modifier la liste non modifiable.
2. Le proxy utilisé est un `java.util.Collections$UnmodifiableList`. Cette classe statique est une implémentattion de `List` qui lève une exception lorsqu'on tente de modifier la liste.

## Exercice 2: Proxy et introspection
