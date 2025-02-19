class C:
    pass

c = C()
c.x = 5
assert c.x == 5 # c.x vaut 5
assert hasattr(c, 'x') # c a un attribut x
assert getattr(c, 'x') == 5 # getattr(c, 'x') renvoie 5
assert not hasattr(c, "y") # c n'a pas d'attribut y
setattr(c, 'y', 7) # on ajoute un attribut y à c
assert hasattr(c, "y") # c a maintenant un attribut y
assert getattr(c, 'y') == 7 # getattr(c, 'y') renvoie 7
assert c.y == 7 # c.y vaut 7
assert vars(c) == {'x': 5, 'y': 7} # les attributs de c sont x=5 et y=7
delattr(c, 'x') # on supprime l'attribut x de c
assert not hasattr(c, 'x') # c n'a plus d'attribut x
assert vars(c) == {'y': 7} # l'attribut de c est y=7
print(dir(c))
