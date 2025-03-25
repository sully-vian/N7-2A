%%%%%%%%%%%%%%%%%%%%%%%%
% Arithmétique cryptée %
%%%%%%%%%%%%%%%%%%%%%%%%

% liste en décimal
decimal([], 0).
decimal([T|Q], N) :-
    length(Q, L),
    decimal(Q, N1),
    N #= T * 10**L + N1.

crypto(Vars) :-
    % déclaration des variables
    Vars = [D, O, N, A, L, G, E, R, B, T],
    fd_domain(Vars, 0, 9),
    fd_all_different(Vars),
    D #\= 0,
    G #\= 0,
    R #\= 0,
    % contraintes
    decimal([D, O, N, A, L, D], DONALD),
    decimal([G, E, R, A, L, D], GERALD),
    decimal([R, O, B, E, R, T], ROBERT),
    (GERALD + DONALD) #= ROBERT,
    % recherche de solution
    fd_labeling(Vars).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nombre de HARDY-RAMANUJAN %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hardy(Vars) :-
    % déclaration des variables
    ABCD = [A, B, C, D],
    Vars = [ N | ABCD],
    fd_domain(ABCD, 0, 1000000),
    fd_domain(N, 0, 1000000),
    % contraintes
    A #\= C,
    A #\= D,
    N #= A**3 + B**3,
    N #= C**3 + D**3,
    % recherche de solution
    fd_labeling(Vars). % TODO: choper que le minimum

%%%%%%%%%%%
% Monnaie %
%%%%%%%%%%%

% sum/2 : somme liste
sum([], 0).
sum([T|Q], T + SQ) :-
    % T sera pas un entier mais une structure de donnée avec des "+"
    sum(Q, SQ).

monnaie(Vars) :-
    % déclaration des variables (en centimes)
    Billets = [B2000, B1000, B500],
    Pieces = [P200, P100, P50, P20, P10, P5, P2, P1],
    append(Billets, Pieces, Vars),
    % contraintes
    fd_domain(Vars, 0, 3), % pas plus de 3 fois la même "pièce"
    Rendu is 2000 - 1729,
    Rendu #= 2000 * B2000 + 1000 * B1000 + 500 * B500 +
        200 * P200 + 100 * P100 + 50 * P50 +
        20 * P20 + 10 * P10 + 5 * P5 +
        2 * P2 + 1 * P1,
    sum(Vars, S),
    Cost #= S,
    % recherche de solution
    fd_minimize(fd_labeling(Vars), Cost). % minimiser le nb de pièces

%%%%%%%%%%%%%%%%%%%%%%
% Chargement de fret %
%%%%%%%%%%%%%%%%%%%%%%

% sum/3 : produit scalaire
sum([], [], 0).
sum([T1 | Q1], [T2 | Q2], T1 * T2 + SQ) :-
    sum(Q1, Q2, SQ).

% importer "fret.pl"
:- initialization(['fret.pl']).

fret(Vars) :-
    % déclaration des variables
    volumes(Vols),
    valeurs(Vals),
    capacite_max(C),
    length(Vols, NumObj),
    length(Vars, NumObj),
    fd_domain(Vars, 0, 1),
    % contraintes
    sum(Vars, Vols, VolTot),
    VolTot #=< C,
    sum(Vars, Vals, ValTot),
    Score #= ValTot,
    % recherche de solution
    fd_maximize(fd_labeling(Vars), Score).
