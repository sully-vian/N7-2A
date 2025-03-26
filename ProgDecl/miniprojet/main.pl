:- initialization(['libtp2.pl']).

%%%%%%%%%%%%%%%%%%
% Modèle basique %
%%%%%%%%%%%%%%%%%%

% squareInside/4
% vrai si le petit carré est dans le grand
squareInside(T, Ti, Xi, Yi) :-
    0 #=< Xi, % pas trop à gauche
    0 #=< Yi, % pas trop bas
    Xi + Ti #=< T, % pas trop à droite
    Yi + Ti #=< T. % pas trop haut

% squaresInside/4
% vrai si tous les petits carrés sont dans le grand
squaresInside(_, [], [], []). % ok si aucun carré
squaresInside(T, [Ti|Tq], [Xi|Xq], [Yi|Yq]) :-
    squareInside(T, Ti, Xi, Yi),
    squaresInside(T, Tq, Xq, Yq). % appel récursif

% notColliding/6
% vrai si les deux carrés ne se recouvrent pas
notColliding(Ti, Xi, Yi, Tj, Xj, Yj) :-
    (Xi + Ti #=< Xj) #\/ (Xj + Tj #=< Xi) #\/ (Yi + Ti #=< Yj) #\/ (Yj + Tj #=< Yi).

% nextsNotColliding/6
% vrai si tous les suivants ne recouvrent pas le carré courant
nextsNotColliding(_, _, _, [], [], []). % vrai si plus de carrés
nextsNotColliding(Ti, Xi, Yi, [Tj|Tq], [Xj|Xq], [Yj|Yq]) :-
    notColliding(Ti, Xi, Yi, Tj, Xj, Yj),
    nextsNotColliding(Ti, Xi, Yi, Tq, Xq, Yq).

solve(Num, Xs, Ys) :-
    % déclaration des variables
    data(Num, T, Ts), % extraire les données de l'instance
    length(Ts, N), % N <- len(Ts)
    length(Xs, N), % Xs est liste de taille N
    length(Ys, N), % Ys est liste de taille N
    % premiers elt de chaque liste
    [T1|Tq] = Ts,
    [X1|Xq] = Xs,
    [Y1|Yq] = Ys,
    % contraintes
    squaresInside(T, Ts, Xs, Ys),
    nextsNotColliding(T1, X1, Y1, Tq, Xq, Yq),
    % recherche de solution
    fd_labeling(Xs),
    fd_labeling(Ys).
