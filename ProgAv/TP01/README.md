# TP1 - Décorateurs en Python

## 1 Création d'un environnement virtuel Python

### Exercice 1

## 2 Quelques éléméents algorithmiques


dans le `.bashrc`

### Exercice 2

```python
>>> a = [8, 1, 4, 6]
>>> b = [8, 1, 4, 6]
>>> c = b
>>> a is b
False
>>> a == b
True
>>> c is b
True
>>> p, *m, d = a # p = 8, m = [1, 4], a = [8, 1, 4, 6]
>>> len(a)
4
>>> a[-1]
6
>>> a[0]
8
>>> x = 'a'
>>> s = str(x) # s = 'a'
>>> r = repr(x) # r = "'a'"
```

### Exercice 3

```python
>>> l = []
>>> for i in range(2, 10):
...     l.append(2 * i + 5)
>>> l
[9, 11, 13, 15, 17, 19, 21, 23]

>>> l = [2 * i + 5 for i in range(2, 10)]
>>> l
[9, 11, 13, 15, 17, 19, 21, 23]
```

### Exercice 4

```python
>>> a = { 1, 2, 3, 4, 3, 2, 1}
>>> b = { 'fr': 'France', 'de': 'Allemagne' }
>>> len(a)
4
>>> len(b)
2
>>> b[5] = 'fr'
>>>b
{'fr': 'France', 'de': 'Allemagne', 5: 'fr'}
>>> x = b['fr']
>>> x
'France'
>>> y = b.get('it', -1)
>>> y
-1
>>> del b[5]
>>> b
{'fr': 'France', 'de': 'Allemagne'}
>>> b.items()
dict_items([('fr', 'France'), ('de', 'Allemagne')])
>>> b.values()
dict_values(['France', 'Allemagne'])
>>> b.keys()
dict_keys(['fr', 'de'])
>>> p = b.pop('fr')
>>> p
'France'
>>> b
{'de': 'Allemagne'}
```

## Les sous-programmes

### Exercice 5: Premier sous-programme

#### 5.1

La fonction `index` permet de récupérer l'indice d'un élément donné dans une séquence (un itérable) donnée. Si l'élément n'est pas trouvé, une exception de type `ValueError` est levée.

#### 5.2

Ce fichier est un script de test utilisant `pytest` pour tester la fonction `index`. Il comprend une fonction de "setup" qui a l'annotation `pytest.fixture` et des fonctions de test nominaux, erreurs et avec d'autres types qu'une liste (une chaine de caractères).

#### 5.3

...

### Execice 6

`p` correspond aux arguments non-nommés. Le symbole `*` permet de récupérer tous les arguments non-nommés dans un tuple. `kw` correspond au dictionnaire des arguments nommés. Le symbole `**` permet de récupérer tous les arguments nommés dans un dictionnaire. L'appel `f(1,2,3)` n'est pas possible car l'argument `x` doit être nommé (se situer après `*p`).

### Exercice 7

1. Le paramètre `f` est la fonction à annuler par dichotomie.
2. Le caractère `*` "mange" tous les arguments non nommés. Il faut donc explicitement nommer l'argument `precision`.
3. `zero(lambda x: x**2 - 2*x - 15, 0, 15, precision=0.01)`

## 4 Décorateurs en Python

### Exercice 8: Comprendre le principe

1. On écrit "dans fn_bavard" à la définition de `exemple`. `exemple` est appelée, etc.
2. Pamal l'animation.
3. `exemple` n'a pas le bon nom, la décoration remplace `exemple` par `fn_bavard`.

### Exercice 9: Décorateur deprecated

voir [`derecated.py`](./deprecated.py)

### Exercice 10: Décorateur trace

1. voir [`trace.py`](./trace.py)
2. TODO
