%%%%% TP2_exo_1.m %%%%%

addpath('matlab_bgl'); %load graph libraries
addpath('matlab_tpgraphe'); %load tp ressources

close all
clear all

load TPgraphe.mat; %load data

%%%%%%%%%%%%%%%%%%%%%% INIT %%%%%%%%%%%%%%%%%%%%%%%%%%%%
G = sparse(D);

%%%%%%%%%%%%%%%%%%%%%% EXO SPT (Shortest Path Tree) %%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SPT: Arbre couvrant des plus courts chemins
% On cherche à miniser le poids de chaque chemin.
% les chemins sont donc en ligne droite.

%0) Choose arbitrary src node for spt
src = 14;
%1) Compute SPT rooted in src node
[wp, spt_] = shortest_paths(G, src); %wp=weight path, spt_=shortsetpathtree structure
%2) Vizualize
viz_spt(G, spt_, pos, cities);

longueur_arbre = sum(wp);

%%%%%%%%%%%%%%%%%%%%%% EXO MST (Minimum Spanning Tree) %%%%%%%%%%%%%%%%%%%%%%%%%%%%

% MST: Arbre couvrant de poids minimal
% On cherche à minimiser le poids max des arêtes (on fait un max d'arrêt).
% Le résultat dépend peu du noeud de départ.

%1) Compute MST by PRIM
%changer les valeurs initiales pour obtenir deux arbres différents entre PRIM et KRUSKAL
mst_ = prim_mst(G, struct('root', src));
%2) Vizualize
viz_mst(G, mst_, pos, cities);

%1) Compute MST by KRUSKAL
mst_ = kruskal_mst(G);
%2) Vizualize
viz_mst(G, mst_, pos, cities);

%%%%%%%%%%%%%%%%%%%%%% EXO FLOW/CUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%

%0) Choose arbitrary srcs, dsts and virtual capacities for these nodes

srcs = [2, 21]; %for europe
dsts = [10, 16]; %for europe
virtual_capacity = 100; %for europe

%1) create bandwdth graph from distance graph
n = size(D, 1);
% add virtual src & dst (so create graph with two extra nodes)
bw = zeros(n + 2, n + 2);
% n+1th node is for virtual src;virtual src connected to srcs cities
bw(n + 1, srcs) = virtual_capacity;
bw(srcs, n + 1) = virtual_capacity;
% n+2th node is for virtual dst;virtual dst connected to dsts cities
bw(n + 2, dsts) = virtual_capacity;
bw(dsts, n + 2) = virtual_capacity;

% bandwidth is invertly proportinal to distance
bw(1:n, 1:n) = 1000 / bw(dsts,dsts); % TODO
% Inf is on the diagonal, so change it to 0
bw(bw == Inf) = 0;
% links with too less bw are not interesting for operators
% TODO: Filtrage des liens non exploitable;%for europe
bw(1:n, 1:n) = bw(1:n, 1:n)(find(bw(1:n,1:n) > 11))

%2) Compute Max flow bw virtual src & dst nodes
Gbw = sparse(bw);
[max_val cut_ R F] = max_flow(Gbw, n + 1, n + 2);

%3) Vizualize
viz_cut(Gbw, cut_, pos, cities, srcs, dsts)
