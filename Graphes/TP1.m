%%%%% SET ENV %%%%%

close all; % close all figures
clear all; % clear all variables

addpath('matlab_bgl'); % load graph libraries
addpath('matlab_tpgraphe'); % load tp ressources

load TPgraphe.mat; % load data

%%%%%% DISPLAY INPUT DATA ON TERMINAL %%%%%

cities; % names of cities
D; %distance matrix bw cities
pos; %x-y pos of the cities

%%%%%% EXO 1 (modéliser et afficher le graphe) %%%%%

d = 500; %distance max pour lier 2 villes
A = (D < d & D > 0); %adj matrix
viz_adj(D, A, pos, cities);

n = 12; % fermeture transitive
viz_adj(D, graphPower(A, n), pos, cities);

%Q2 -
% En augmentant n, on constate l'appartion de chemins montrant que des vilels sont connectées par l'intermédiaire d'autres villes. Le graphe n'est finalement plus composé que de composantes connexes.

%%%%%% EXO 2 %%%%%

%Q1 - existence d'un chemin de longueur 3
A3 = graphPower(A, 3); % chemins de longueur <= 3
A2 = graphPower(A, 2); % chemins de longueur <= 2

if (sum(sum(A3 - A2)) > 0)
    disp('Il existe un chemin de longueur 3');
else
    disp('Il n''existe pas de chemin de longueur 3');
end

%Q2 - nb de chemins de 3 sauts
nbex3 = sum(A3 - A2, 'all');
disp('il y a ' + string(nbex3) + ' chemins de 3 sauts exactement');

%Q3 - nb de chemins <=3
nbinfex3 = sum(A3, 'all');
disp('il y a ' + string(nbinfex3) + ' chemins de 3 sauts ou moins');

%%%%%%%% EXO 3 %%%%%
c = [18 13 9]; % la chaine 18 13 9 est t dans le graphe ?
possedechaine(A, c)
c = [18 6 3]; % la chaine 18 6 3 est t dans le graphe ?
possedechaine(A, c)
c = [26 5 17]; % la chaine 26 5 17 est t dans le graphe ?
possedechaine(A, c)

%%%%%%%% EXO 4%%%%%
isEulerien(A)

%%%%%%%% EXO 5%%%%%
porteeEulerien(D)
