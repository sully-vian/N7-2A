%%%%%%%%%%%%%%
% Question 1 %
%%%%%%%%%%%%%%

:- dynamic(on/2).
on(a, b).
on(b, c).
on(c, table).
%%%%%%%%%%%%%%
% Question 2 %
%%%%%%%%%%%%%%

% put_on(A, B).
% Pré:
% - rien sur A
% - A != floor
% - A != B
% rien sur B ou B = table
% Post:
% - A sur B

%%%%%%%%%%%%%%
% Question 3 %
%%%%%%%%%%%%%%

put_on_pre(A, B) :-
    \+ on(_, A), % rien sur A
    A \= B, % A != B
    A \= table, % A != table
    (\+ on(_, B); B = table). % rien sur B ou B = table

put_on_post(A, B) :-
    on(A, B). % A sur B

%%%%%%%%%%%%%%
% Question 4 %
%%%%%%%%%%%%%%

:- dynamic(move/2).
put_on_4(A, B) :-
    put_on_pre(A, B),
    retract(on(A,_)),
    assertz(on(A, B)),
    assertz(move(A, B)),
    put_on_post(A, B).

%%%%%%%%%%%%%%
% Question 5 %
%%%%%%%%%%%%%%

:- dynamic(move/2).
put_on(A, B) :-
    put_on_pre(A, B),
    retract(on(A,_)),
    assertz(on(A, B)),
    assertz(move(A, B)), % ajout question 5
    put_on_post(A, B).

%%%%%%%%%%%%%%
% Question 6 %
%%%%%%%%%%%%%%

%?- put_on(a,table).
% yes

% ?- put_on(c,a).
% no
% impossible car c n'est pas libre (on(b,c))

% ?- put_on(b,table), put_on(c,a).
% true ?
% yes
% en libérant c, on peut mettre c sur a

%%%%%%%%%%%%%%
% Question 7 %
%%%%%%%%%%%%%%

% clear/1
clear(table). % rien à faire pur clear la table
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

%%%%%%%%%%%%%%
% Question 8 %
%%%%%%%%%%%%%%

%%%%%%%
% (a) %
%%%%%%%

% achieve_naive/1
% prend en paramètre une liste de termes représentant des buts à atteindre et
% affiche les actions nécessaires à la satisfaction de ces buts.
% ex: achieve([on(a,c), on(c,b)])
achieve_naive(Goals) :-
    prepare_achieve(OnEnv, MoveEnv), % on sauvegarde et prépare l'environnement
    achieve_naive_aux(Goals), % on réalise les buts
    !, % on stop le backtracking ici
    listing(move), % on affiche les moves
    restore_achieve(OnEnv, MoveEnv). % on restore l'environnement

% achieve_naive_aux/1
% réalise les buts de la liste Goals dans l'ordre où ils sont donnés.
achieve_naive_aux([]). % rien à faire
achieve_naive_aux([H | T]) :-
    H = on(A, B),
    r_put_on(A, B),
    achieve_naive_aux(T).

% prepare_achieve/2
% enregistre les ons et moves et supprime les moves
prepare_achieve(OnEnv, MoveEnv) :-
    findall(on(X,Y), on(X,Y), OnEnv), % on enregistre les ons
    findall(move(X,Y), move(X,Y), MoveEnv), % on enregistre les moves
    retractall(move(_, _)). % on enlève tous les moves d'avant

% restore_achieve/2
restore_achieve(OnEnv, MoveEnv) :-
    retractall(on(_, _)), % on enlève tous les ons
    assert_all(OnEnv), % on remet les ons d'origine
    retractall(move(_, _)), % on enlève tous les moves (ceux ajoutés par achieve)
    assert_all(MoveEnv). % on remet les moves d'origine

assert_all([]).
assert_all([H | T]) :-
    assertz(H),
    assert_all(T).

%%%%%%%
% (b) %
%%%%%%%

% l'approche naive ne fonctionne pas car l'appel récursif peut invalider les
% buts précédents.
% Ici par exemple, le fait de mettre c sur b nécesite de libérer c et donc
% d'invalider on(a,c).
% Il faut donc trier les buts pour réaliser ceux qui sont plus "bas" en premier.
% ex: achieve([on(a,c), on(c,b)]) -> achieve([on(c,b), on(a,c)])

%%%%%%%
% (c) %
%%%%%%%

% Je peux décrire la liste voulue comme contenant les mêmes éléments que la
% liste d'origine mais telle qu'aucun élément suivant un on(_,b) ne soit un
% on(b,_).

% right_order_pair/2
% vrai si on(A,B) peut être réalisé avant on(C,D) sans que cela ne pose de
% problème.
right_order_pair(on(_,B), on(C,_)) :-
    B \= C.

% right_order_list/2
% vrai si les suivants de On sont légalement après On
right_order_list(_, []). % bon ordre si aucun suivant
right_order_list(On, [H | T]) :-
    right_order_pair(On, H), % On est légalement avant H
    right_order_list(On, T). % les autres suivants sont aussi légalement après

% right_order/2
% vrai si la liste complète de buts est dans le bon ordre
right_order([]). % aucun but: rien à vérifier
right_order([H | T]) :- % au moins un but
    right_order_list(H, T), % vérifier que les suivants sont dans le bon ordre
    right_order(T). % vérifier les suivants de H

% sort_list/2
sort_list([], []). % liste vide, rien à trier
sort_list([H | T], Out) :-
    In = [H | T], % In est la liste d'origine
    permutation(In, Out), % Out est une permutation de In
    right_order(Out), % vérifier que Out est dans le bon ordre
    !. % stop le backtracking ici

% achieve/1
achieve(Goals) :-
    listing(on),
    sort_list(Goals, SortedGoals), % trier la liste
    achieve_naive(SortedGoals).