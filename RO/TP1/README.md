---
geometry: margin=2cm
---

# Sujet 1 : Modélisation + Résolution de PL/PLNE avec le solveur GLPK

## Assemblage

On modélise la situation par le probème suivant :

$$
\begin{aligned}
    \max \quad & 700n_c + 300n_s \\
    \text{s.t.} \quad & (n_s,n_c) \in \mathbb{N}^2 \\
    & n_c, n_s \geqslant 0 \\
    & n_c \leqslant 700 \\
    & 2.5n_c + n_s \leqslant 1500 \\
    & \tfrac{6}{100}n_c + \tfrac{5}{100}n_s \leqslant 60 \\
\end{aligned}
$$

où $n_c$ et $n_s$ sont respectivement le nombre de vélo cargo C et de vélo standard S à produire.

La modélisation de ce problème se trouve dans `assemblage.lp`. On lance le solveur GLPK avec la commande suivante :

```bash
./glpsol --lp assemblage.lp -o assemblage.sol
```

On trouve la solution optimale décrite dans `assemblage.sol`.

## Affectation avec prise en compte des préférences

Pour cette situation, on va considérer les paires personne-tache et les modéliser par un "booléen" $A_{i,j}$ qui vaut $1$ si la personne $i$ est affectée à la tâche $j$ et $0$ sinon.

Le problème s'écrit donc :

$$
\begin{aligned}
    \max \quad & \sum_{i,j=1}^{N} c(i,j) \times A_{i,j} \\
    \text{s.t.} \quad & A \in \{0,1\}^{N \times N} \\
    & \sum_{j=1}^{N} A_{i,j} = 1 \quad \forall i \in \{1,\ldots,N\} \\
    & \sum_{i=1}^{N} A_{i,j} = 1 \quad \forall j \in \{1,\ldots,N\} \\
\end{aligned}
$$

Le modèle de ce problème se trouve dans `affectation.mod`. On définit la matrice de préférence dans `affectation.dat` et on lance le solveur GLPK avec la commande suivante :

```bash
./glpsol -m affectation.mod -d affectation.dat -o affectation.sol
```

On trouve la solution optimale décrite dans `affectation.sol`.

## Cas particulier 1.1

Pour cette situation, on pose comme variable la matrice $vol$ telle que $vol_{f,m,d}$ est le volume du fluide $f$ venant du magasin $m$ allant au demandeur $d$. En appelant A, B et C les matrices des tableaux de données, on a :

$$
\begin{aligned}
    \min \quad & \sum_{f,d,m} vol_{f,m,d} \times C_{m,f} \\
    & vol_{f,m,d} \geqslant 0 \quad \forall f \quad \forall m \quad \forall d \\
    & \sum_{m} vol_{f,m,d} = A_{d,f} \quad \forall d \quad \forall f \\
    & \sum_{d} vol_{f,m,d} \leqslant B_{m,f} \quad \forall m \quad \forall f \\
\end{aligned}
$$

Le modèle de ce problème se trouve dans `cas_particulier_1_1.mod`. On définit les données dans `cas_particulier_1_1.dat` et on lance le solveur GLPK avec la commande suivante :

```bash
./glpsol -m cas_particulier_1_1.mod -d cas_particulier_1_1.dat -o cas_particulier_1_1.sol
```

## Cas particulier 1.2

Ce problème étend le précédent en ajoutant d'autres coûts. On n'a donc pas de nouvelle contrainte, mais seulement un changement de la fonction objectif. En appelant D et E les matrices des tableaux de données, on a :

$$
\begin{aligned}
    \min \quad & \sum_{f,d,m} vol_{f,m,d} \times C_{m,f} + D_{d,m} + E_{d,m} \\
    & vol_{f,m,d} \geqslant 0 \quad \forall f \quad \forall m \quad \forall d \\
    & \sum_{m} vol_{f,m,d} = A_{d,f} \quad \forall d \quad \forall f \\
    & \sum_{d} vol_{f,m,d} \leqslant B_{m,f} \quad \forall m \quad \forall f \\
\end{aligned}
$$

Le modèle de ce problème se trouve dans `cas_particulier_1_2.mod`. On définit les données dans `cas_particulier_1_2.dat` et on lance le solveur GLPK avec la commande suivante :

```bash
./glpsol -m cas_particulier_1_2.mod -d cas_particulier_1_2.dat -o cas_particulier_1_2.sol
```

## Cas particulier 2

1. Ce problème corrrespond au problème du voyageur de commerce, où on aurait imposé le point de départ.

2. La situation ressemble en quelque sorte au problème d'affectation traité plus haut. C'est pourquoi nous avaons introduit une variable matrice $trajets_{i,j}$ qui vaut $1$ si le livreur livre le client $i$ puis drirectment après le client $j$, et $0$ sinon. Ensuite, plus qu'à multiplier par la distance associée dans les données et on a la distance totale du circuit.

    Toutefois, il manque la contrainte d'interdire les sous-boucles, qui est difficile à écrire. Pour cela nous avons introduit une variable vecteur $rang$ qui tient compte du rang de chaque client visité. Le magasin ALPHA doit avoir un rang de $1$, et tous les clients ont un rang distinct entre $2$ et $n$ (avec $n$ le nombre de clients). On a donc:

    $$rang_i-rang_j + n \times trajets_{i,j} \leqslant n-1 \quad \forall i,j \neq \text{ALPHA}, i\neq j$$

    En effet, on capture ici que si $i$ et $j$ se succèdent, $rang_i + 1 = rang_j$. De plus, cette variable mettra facilement en évidence le trajet complet du livreur dans la fichier solution.

Le problème complet s'écrit donc, avec $dist$ la matrice donnée des distances :

$$
\begin{aligned}
    \min \quad & \sum_{i,j} trajets_{i,j} \times dist_{i,j} \\
    & trajets_{i,j} \in \{0,1\} \quad \forall i,j \\
    & trajets_{i,i} = 0 \quad \forall i \\
    & \sum_{j} trajets_{i,j} = 1 \quad \forall i \neq \text{ALPHA} \\
    & \sum_{i} trajets_{i,j} = 1 \quad \forall j \neq \text{ALPHA} \\
    & rang_i \in [\![1,n]\!] \quad \forall i \\
    & rang_{\text{ALPHA}} = 1 \\
    & rang_i-rang_j + n \times trajets_{i,j} \leqslant n-1 \quad \forall i,j \neq \text{ALPHA}, i\neq j \\
\end{aligned}
$$

## Minimisation des émissions polluantes
