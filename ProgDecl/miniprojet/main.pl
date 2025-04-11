% 2SNL Informatique - PDL/PPC
% Vianney Hervy - vhy9665
% 2SN - L2

:- include(libtp2).

%%%%%%%%%%%%%%%%%%
% Modèle basique %
%%%%%%%%%%%%%%%%%%

%%%%%
% 1 %
%%%%%

% domains/4
% vrai si les Xi et Yi sont dans leurs domaines respectifs
domains([], [], [], _). % ok si aucune variable
domains([Xi|Xq], [Yi|Yq], [Ti|Tq], T) :-
    Maxi is T - Ti, % borne supérieure en i
    fd_domain(Xi, 0, Maxi), % domaine de Xi
    fd_domain(Yi, 0, Maxi), % domaine de Yi
    domains(Xq, Yq, Tq, T). % appel récursif

% notColliding/6
% vrai si les carrés i et j ne se recouvrent pas
notColliding(Ti, Xi, Yi, Tj, Xj, Yj) :-
    (Xi + Ti #=< Xj) #\/
    (Xj + Tj #=< Xi) #\/
    (Yi + Ti #=< Yj) #\/
    (Yj + Tj #=< Yi).

% nextsNotColliding/6
% vrai si tous les suivants ne recouvrent pas le carré courant
nextsNotColliding(_, _, _, [], [], []). % vrai si plus de carrés
nextsNotColliding(Ti, Xi, Yi, [Tj|Tq], [Xj|Xq], [Yj|Yq]) :-
    notColliding(Ti, Xi, Yi, Tj, Xj, Yj), % i et j ne se recouvrent pas
    nextsNotColliding(Ti, Xi, Yi, Tq, Xq, Yq). % i ne recouvre aucun suivant de j

% NoneColliding/3
% vrai si tous les carrés ne se recouvrent pas
noneColliding([], [], []). % vrai si aucune variable
noneColliding([Ti|Tq], [Xi|Xq], [Yi|Yq]) :-
    % tous les carrés suivants ne recouvrent pas le premier
    nextsNotColliding(Ti, Xi, Yi, Tq, Xq, Yq),
    noneColliding(Tq, Xq, Yq). % appel récursif

% solve/4
% vrai si la solution est trouvée
% Num (in): numéro de l'instance
% Xs (out): liste des abscisses des petits carrés
% Ys (out): liste des ordonnées des petits carrés
% B (out): nombre de backtracks
solve1(Num, Xs, Ys, B) :-
    data(Num, T, Ts), % extraire les données de l'instance

    % déclaration des variables
    length(Ts, N), % N <- len(Ts)
    length(Xs, N), % Xs est liste de taille N
    length(Ys, N), % Ys est liste de taille N
    domains(Xs, Ys, Ts, T), % domaines de Xs et Ys

    % contraintes
    noneColliding(Ts, Xs, Ys),

    % recherche de solution
    append(Xs, Ys, Vars),
    fd_labeling(Vars, [backtracks(B)]).

%%%%%
% 2 %
%%%%%

% J'obtiens la solution suivante:
% Xs = [0,0,1,2,2,2]
% Ys = [0,2,2,0,1,2]

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

% redondance/4
% vrai si sliceSum est vrai pour toutes les verticales / horizontales (en
% fonction de l'appel avec Xs ou Ys)
redondance(T, _, _, T).
redondance(I, Ts, Zs, T) :-
    % I est l'indice de la verticale / de l'horizontale
    sliceSum(I, Ts, Zs, T), % vérif de la somme
    % appel récursif sur la verticale / horizontale suivante
    I1 is I + 1,
    redondance(I1, Ts, Zs, T).

% solve2/4
% Idem que solve1 mais avec des contraintes redondantes
solve2(Num, Xs, Ys, B) :-
    data(Num, T, Ts), % extraire les données de l'instance

    % déclaration des variables
    length(Ts, N), % N <- len(Ts)
    length(Xs, N), % Xs est liste de taille N
    length(Ys, N), % Ys est liste de taille N
    domains(Xs, Ys, Ts, T), % domaines de Xs et Ys

    % contraintes
    noneColliding(Ts, Xs, Ys),
    redondance(0, Ts, Xs, T), % vérif de l'horizontale
    redondance(0, Ts, Ys, T), % vérif de la verticale

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
    data(Num, T, Ts), % extraire les données de l'instance

    % déclaration des variables
    length(Ts, N), % N <- len(Ts)
    length(Xs, N), % Xs est liste de taille N
    length(Ys, N), % Ys est liste de taille N
    domains(Xs, Ys, Ts, T), % domaines de Xs et Ys

    % contraintes
    noneColliding(Ts, Xs, Ys),
    redondance(0, Ts, Xs, T), % vérif de l'horizontale
    redondance(0, Ts, Ys, T), % vérif de la verticale

    % recherche de solution
    labeling(Xs, Ys, indomain, minmin, B, NbSol).

%%%%%
% 2 %
%%%%%

% Avec assign, l'instance 2 demande 805 backtracks.
% Avec indomain, l'instance 2 demande 9038 backtracks.
% indomain sélectionne arbitrairement les variables dans l'ordre où elles
% apparaissent dans leur domaine. assign associé à minmin choisit plus
% intelligemment les variables à assigner. Il en résulte une convergence plus
% rapide, avec moins de backtracks.

%%%%%%%%%%%%%
% Symétries %
%%%%%%%%%%%%%

%%%%%
% 1 %
%%%%%

% lexSort/6
% vrai si les carrés de même taille sont triés lexicographiquement par rapport à
% leurs coordonnées
lexSort(_, _, _, [], [], []). % vrai si aucun carré restant
lexSort(_, _, Ti, _, _, [Tj|_]) :- % vrai si les tailles sont différentes
    Ti #\= Tj. % pas de même taille
lexSort(Xi, Yi, Ti, [Xj|Xq], [Yj|Yq], [Tj|Tq]) :-
    Ti #= Tj, % même taille
    Xi #=< Xj, % tri par rapport à l'abscisse
    (Xi #\= Xj #\/ Yi #< Yj), % tri par rapport à l'ordonnée
    lexSort(Xi, Yi, Ti, Xq, Yq, Tq). % appel récursif

% lexSort/3
% vrai si tous les carrés de même taille sont triés lexicographiquement par
% rapport à leurs coordonnées
lexSort([], [], []). % liste triée si vide
lexSort([Xi|Xq], [Yi|Yq], [Ti|Tq]) :-
    lexSort(Xi, Yi, Ti, Xq, Yq, Tq), % vérif de l'ordre avec i
    lexSort(Xq, Yq,Tq). % appel récursif sur les autres carrés

% solve4/5
% Idem que solve3 mais avec rupture de la symétrie de permuation
solve4(Num, Xs, Ys, B, NbSol) :-
    data(Num, T, Ts), % extraire les données de l'instance

    % déclaration des variables
    length(Ts, N), % N <- len(Ts)
    length(Xs, N), % Xs est liste de taille N
    length(Ys, N), % Ys est liste de taille N
    domains(Xs, Ys, Ts, T), % domaines de Xs et Ys

    % contraintes
    noneColliding(Ts, Xs, Ys),
    redondance(0, Ts, Xs, T), % vérif de l'horizontale
    redondance(0, Ts, Ys, T), % vérif de la verticale
    lexSort(Xs, Ys, Ts),

    % recherche de solution
    labeling(Xs, Ys, indomain, minmin, B, NbSol).

% Sans LexSort, on a 480 solutions à l'instance 1.
% Avec lexSort, il n'en reste plus que 4 distinctes.
% Ces 4 distinctes ne sont que des rotations d'une solution unique.

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
    ; SolveNum = 4 -> solve4(Num, Xs, Ys, B, NbSol)
    ),
    data(Num, _, Ts),
    format('Num backtracks: ~w~n', [B]),
    ( SolveNum = 3 ; SolveNum = 4 -> format('Number of solutions: ~w~n', [NbSol]) ; true ),
    printsol('tiles.txt', Xs, Ys, Ts).
