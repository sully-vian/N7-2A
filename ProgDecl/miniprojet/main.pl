% Vianney Hervy - vhy9665
% 2SN - L2

:- initialization(['libtp2.pl']).

%%%%%%%%%%%%%%%%%%
% Modèle basique %
%%%%%%%%%%%%%%%%%%

%%%%%
% 1 %
%%%%%

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
    notColliding(Ti, Xi, Yi, Tj, Xj, Yj), % i et j ne se recouvrent pas
    nextsNotColliding(Ti, Xi, Yi, Tq, Xq, Yq), % appel récursif avec i
    nextsNotColliding(Tj, Xj, Yj, Tq, Xq, Yq). % appel récursif avec j

% solve/4
% vrai si la solution est trouvée
% Num (in): numéro de l'instance
% Xs (out): liste des abscisses des petits carrés
% Ys (out): liste des ordonnées des petits carrés
% B (out): nombre de backtracks
solve1(Num, Xs, Ys, B) :-
    % déclaration des variables
    data(Num, T, Ts), % extraire les données de l'instance
    length(Ts, N), % N <- len(Ts)
    length(Xs, N), % Xs est liste de taille N
    length(Ys, N), % Ys est liste de taille N
    fd_domain(Xs, 0, T),
    fd_domain(Ys, 0, T),
    % premiers elt de chaque liste
    [T1|Tq] = Ts,
    [X1|Xq] = Xs,
    [Y1|Yq] = Ys,

    % contraintes
    squaresInside(T, Ts, Xs, Ys),
    nextsNotColliding(T1, X1, Y1, Tq, Xq, Yq),

    % recherche de solution
    append(Xs, Ys, Vars),
    fd_labeling(Vars, [backtracks(B)]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Contraintes redondantes %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% sliceSum/4
% vrai si S est la somme des tailles des petits carrés coupés par la
% verticale / horizontale I
sliceSum(_, [], [], 0).
sliceSum(I, [Ti | Tq], [Zi | Zq], S) :-
    (Zi #=< I #/\ I #< Zi + Ti) #<=> B, % B rpz si le carré est coupé ou non
    sliceSum(I, Tq, Zq, S1), % somme des autres
    S #= S1 + B * Ti. % somme courante

% redondance/5
redondance(T, _, _, _, T).
redondance(I, Ts, Xs, Ys, T) :-
    % I est l'indice de la verticale / de l'horizontale
    sliceSum(I, Ts, Xs, T), % vérif sur la verticale
    sliceSum(I, Ts, Ys, T), % vérif sur l'horizontale
    % appel récursif sur la verticale / horizontale suivante
    I1 #= I + 1,
    redondance(I1, Ts, Xs, Ys, T).

% solve2/4
% Idem que solve1 mais avec des contraintes redondantes
solve2(Num, Xs, Ys, B) :-
    % déclaration des variables
    data(Num, T, Ts), % extraire les données de l'instance
    length(Ts, N), % N <- len(Ts)
    length(Xs, N), % Xs est liste de taille N
    length(Ys, N), % Ys est liste de taille N
    fd_domain(Xs, 0, T),
    fd_domain(Ys, 0, T),
    % premiers elt de chaque liste
    [T1|Tq] = Ts,
    [X1|Xq] = Xs,
    [Y1|Yq] = Ys,

    % contraintes
    squaresInside(T, Ts, Xs, Ys),
    nextsNotColliding(T1, X1, Y1, Tq, Xq, Yq),

    % contraintes redondantes
    redondance(0, Ts, Xs, Ys, T),

    % recherche de solution
    append(Xs, Ys, Vars),
    fd_labeling(Vars, [backtracks(B)]).

%%%%%
% 2 %
%%%%%

% Avec le modèle basique, j'ai 106 backtracks avant la prmière solution et 1485
% avant la dernière solution.
% En ajoutant les contraintes redondantes, je n'ai plus que 0 backtrack avant la
% première solution et 479 avant la dernière
% Il semblerait que les contraintes redondantes permettent d'orienter la
% recherche pour une convergence plus rapide.

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Stratégie de recherche %
%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%
% 1 %
%%%%%

% solve3/5
% Idem que solve2 mais avec labeling
% NbSol (out): nombre de solutions trouvées
solve3(Num, Xs, Ys, B, NbSol) :-
    % déclaration des variables
    data(Num, T, Ts), % extraire les données de l'instance
    length(Ts, N), % N <- len(Ts)
    length(Xs, N), % Xs est liste de taille N
    length(Ys, N), % Ys est liste de taille N
    fd_domain(Xs, 0, T),
    fd_domain(Ys, 0, T),
    % premiers elt de chaque liste
    [T1|Tq] = Ts,
    [X1|Xq] = Xs,
    [Y1|Yq] = Ys,

    % contraintes
    squaresInside(T, Ts, Xs, Ys),
    nextsNotColliding(T1, X1, Y1, Tq, Xq, Yq),

    % contraintes redondantes
    redondance(0, Ts, Xs, Ys, T),

    % recherche de solution
    labeling(Xs, Ys, assign, minmin, B, NbSol).

%%%%%
% 2 %
%%%%%

% Je n'arrive pas à faire fonctionner la deuxième instance, même en augmentant
% CSTRSZ, LOCALSZ, GLOBALSZ et TRAILSZ.

%%%%%%%%%%%%%
% Symétries %
%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%
% Fonctions auxiliaires %
%%%%%%%%%%%%%%%%%%%%%%%%%

% pour afficher la solution trouvée
% gnuplot --persist -e "plot 'tiles.txt' with lines"

% solveAndPrint/2
% raccourcit imprime la sol dans 'tiles.txt'
solveAndPrint(Num, SolveNum) :-
    ( SolveNum = 1 -> solve1(Num, Xs, Ys, B)
    ; SolveNum = 2 -> solve2(Num, Xs, Ys, B)
    ; SolveNum = 3 -> solve3(Num, Xs, Ys, B, NbSol)
    ),
    data(Num, _, Ts),
    format('Num backtracks: ~w~n', [B]),
    ( SolveNum = 3 -> format('Number of solutions: ~w~n', [NbSol]) ; true ),
    printsol('tiles.txt', Xs, Ys, Ts).
