% Question 1
:- dynamic(on/2).
on(a, b).
on(b, c).
on(c, table).

% Question 2
% put_on(A, B).
% Pré:
% - rien sur A
% - A != floor
% - A != B
% rien sur B ou B = table
% Post:
% - A sur B

% Question 3
put_on_pre(A, B) :-
    \+ on(_, A), % rien sur A
    A \= B, % A != B
    A \= table, % A != table
    (\+ on(_, B); B = table). % rien sur B ou B = table

put_on_post(A, B) :-
    on(A, B). % A sur B

% Question 4-5
:- dynamic(move/2).
put_on(A, B) :-
    put_on_pre(A, B),
    retract(on(A,_)),
    assertz(on(A, B)),
    assertz(move(A, B)), % ajout question 5
    put_on_post(A, B).

% Question 6
%?- put_on(a,table).
% yes

% ?- put_on(c,a)
% no

% put_on(b,table), put_on(c,a)

% Question 7
% clear/1
clear(A) :- % clear A quand rien dessus: izi
    \+ on(_, A).
clear(A) :- % clear A quand B dessus: récursif
    on(B, A), % B sur A
    clear(B), % clear B
    put_on(B, table). % poser B sur la table

% r_put_on/2
r_put_on(A,B) :- % ne rien faire si A déjà sur B
    on(A,B).
r_put_on(A,B) :- % clear les deux avant de mettre A sur B
    clear(A), % libérer A
    clear(B), % libérer B
    put_on(A, B). % placer A sur B

% Question 8
% achieve/1
% prend en paramètre une liste de termes représentant des buts à atteindre et affiche les actions nécessaires à la satisfaction de ces buts.
% ex: achieve([on(a,c), on(c,b)])
achieve([]).
achieve([H | T]) :-
    H = on(A, B),
    r_put_on(A, B),
    achieve(T).

% ne marche pas car l'appel récursif peut invalider les actions précédentes.
% Il faut "trier" les buts pour réaliser les on les plus bas en premier.
% ex: achieve([on(a,c), on(c,b)]) -> achieve([on(c,b), on(a,c)])
