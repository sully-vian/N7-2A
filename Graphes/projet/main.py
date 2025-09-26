import csv
import os
import random
import time
from itertools import combinations

import matplotlib.pyplot as plt
import networkx as nx
import numpy as np
import argparse


def readCSV(filename: str) -> list[list[float]]:
    with open(filename, newline='') as csvfile:
        spamreader = csv.reader(csvfile, delimiter=',')
        datalist = list(spamreader)
        points = []
        for row in datalist[1:]:
            x = float(row[1])
            y = float(row[2])
            z = float(row[3])
            points.append([x, y, z])
    return points


def plotPoints(points: list[list[float]]) -> None:
    fig = plt.figure()
    # fig.suptitle("Positions des satellites")
    ax = fig.add_subplot(projection='3d')
    ax = fig.add_subplot(projection='3d')
    ax.view_init(elev=40, azim=-130)
    xs = [point[0] for point in points]
    ys = [point[1] for point in points]
    zs = [point[2] for point in points]
    ax.scatter(xs, ys, zs)
    # retirer les labels
    ax.set_xticklabels([])
    ax.set_yticklabels([])
    ax.set_zticklabels([])


def getGraph(points: list, reach: int) -> nx.Graph:
    G = nx.Graph()
    for i in range(len(points)):
        xi = points[i][0]
        yi = points[i][1]
        zi = points[i][2]
        G.add_node(i, pos=(xi, yi, zi))
        for j in range(len(points)):
            if i == j:
                continue
            xj = points[j][0]
            yj = points[j][1]
            zj = points[j][2]
            dist2 = (xi-xj)**2 + (yi-yj)**2 + (zi-zj)**2
            if dist2 <= reach**2:
                G.add_edge(i, j)
    return G


def plotGraph(G: nx.Graph) -> None:
    pos = nx.get_node_attributes(G, 'pos')
    node_xyz = np.array([pos[n] for n in G.nodes()])
    edge_xyz = np.array([(pos[u], pos[v]) for u, v in G.edges()])

    # Create the'3D'figure
    fig = plt.figure()
    # fig.suptitle("Graphe des satellites")
    ax = fig.add_subplot(projection='3d')
    ax = fig.add_subplot(projection='3d')
    ax.view_init(elev=40, azim=-130)
    ax.scatter(*node_xyz.T)
    # Plot the edges
    for vizedge in edge_xyz:
        ax.plot(*vizedge.T, color="tab:gray")
    # retirer les labels
    ax.set_xticklabels([])
    ax.set_yticklabels([])
    ax.set_zticklabels([])


def getDegrees(G: nx.Graph) -> list:
    degreesPerNode = list(G.degree([i for i in range(len(G.nodes))]))
    return [v for _, v in degreesPerNode]


def getAvgDegree(G: nx.Graph) -> int:
    degrees = getDegrees(G)
    return sum(degrees) / len(degrees)


def plotDegrees(G: nx.Graph) -> None:
    degrees = getDegrees(G)
    fig = plt.figure()
    # fig.suptitle("Degrés des satellites")
    ax = fig.add_subplot(projection='3d')
    ax.view_init(elev=40, azim=-130)
    pos = nx.get_node_attributes(G, 'pos')
    node_xyz = np.array([pos[n] for n in G.nodes()])
    ax.scatter(*node_xyz.T, c=degrees, cmap='jet')
    # retirer les labels
    ax.set_xticklabels([])
    ax.set_yticklabels([])
    ax.set_zticklabels([])


def plotDegreeHist(G: nx.Graph) -> None:
    degrees = getDegrees(G)
    n_bins = 10
    fig = plt.figure()
    # fig.suptitle("Distribution du degré")
    plt.hist(degrees, bins=n_bins)


def getLocalClusteringDegrees(G: nx.Graph) -> list:
    d = getDegrees(G)
    numTriangles = nx.triangles(G)
    return [numTriangles[i] / (d[i]*(d[i]-1) / 2) if d[i] > 1 else 0 for i in range(len(G.nodes()))]


def getAvgClusteringDegree(G: nx.Graph) -> int:
    clustDeg = getLocalClusteringDegrees(G)
    return sum(clustDeg) / len(clustDeg)


def plotClusteringDegrees(G: nx.Graph) -> None:
    clustDeg = getLocalClusteringDegrees(G)
    fig = plt.figure()
    # fig.suptitle("Degrés de clustering des satellites")
    ax = fig.add_subplot(projection='3d')
    ax.view_init(elev=40, azim=-130)

    pos = nx.get_node_attributes(G, 'pos')
    node_xyz = np.array([pos[n] for n in G.nodes()])
    ax.scatter(*node_xyz.T, c=clustDeg, cmap='jet')
    # retirer les labels
    ax.set_xticklabels([])
    ax.set_yticklabels([])
    ax.set_zticklabels([])


def plotClusteringDegreeHist(G: nx.Graph) -> None:
    clusteringDegrees = getLocalClusteringDegrees(G)
    n_bins = 10
    fig = plt.figure()
    # fig.suptitle("Distribution du degré de clustering")
    plt.hist(clusteringDegrees, bins=n_bins)


def getCliques(G: nx.Graph) -> list:
    return list(nx.find_cliques(G))


def getNumberCliques(G: nx.Graph) -> int:
    return len(getCliques(G))


def plotCliques(G: nx.Graph) -> None:
    pos = nx.get_node_attributes(G, 'pos')
    cliques = getCliques(G)
    fig = plt.figure()
    # fig.suptitle("Cliques de satellites")
    ax = fig.add_subplot(projection='3d')
    ax.view_init(elev=40, azim=-130)
    nbCliques = getNumberCliques(G)
    # colormap that streatches from 0 to len(cliques)
    colors = plt.get_cmap('hsv', len(cliques))
    colorsRandom = [colors(k) for k in range(nbCliques)]
    random.shuffle(colorsRandom)
    for k in range(nbCliques):
        clique = cliques[k]
        if len(clique) == 1:
            continue
        elif len(clique) == 2:
            edge_xyz = np.array([pos[clique[0]], pos[clique[1]]])
            ax.plot(*edge_xyz.T, color=colorsRandom[k])
        else:
            combinaison = combinations(clique, 2)
            edge_xyz = np.array([(pos[u], pos[v])
                                for u, v in combinaison if (u, v) in G.edges()])
            for vizedge in edge_xyz:
                ax.plot(*vizedge.T, color=colorsRandom[k])
    pos = nx.get_node_attributes(G, 'pos')
    node_xyz = np.array([pos[n] for n in G.nodes()])
    ax.scatter(*node_xyz.T, c='gray')
    # retirer les labels
    ax.set_xticklabels([])
    ax.set_yticklabels([])
    ax.set_zticklabels([])


def getConnectedComponents(G: nx.Graph) -> list:
    return list(nx.connected_components(G))


def getNumberConnectedComponents(G: nx.Graph) -> int:
    return nx.number_connected_components(G)


def plotConnectedComponents(G: nx.Graph) -> None:
    pos = nx.get_node_attributes(G, 'pos')
    connectedComponents = getConnectedComponents(G)
    fig = plt.figure()
    # fig.suptitle("Composantes connexes de satellites")
    ax = fig.add_subplot(projection='3d')
    ax.view_init(elev=40, azim=-130)

    # colormap that streatches from 0 to len(cliques)
    colors = plt.get_cmap('hsv', getNumberConnectedComponents(G))
    k = 0
    for component in connectedComponents:
        k += 1
        if len(component) == 1:
            continue
        else:
            combinaison = combinations(component, 2)
            edge_xyz = np.array([(pos[u], pos[v])
                                for u, v in combinaison if (u, v) in G.edges()])
            for vizedge in edge_xyz:
                ax.plot(*vizedge.T, color=colors(k))

    pos = nx.get_node_attributes(G, 'pos')
    node_xyz = np.array([pos[n] for n in G.nodes()])
    ax.scatter(*node_xyz.T, c='gray')
    # retirer les labels
    ax.set_xticklabels([])
    ax.set_yticklabels([])
    ax.set_zticklabels([])


def getShortestPath(G: nx.Graph) -> dict:
    """Un dictionnaire dont les cles est le point d'origine et l'élément est un dictionnaire dont les cles sont les points d'arrivés et la valeur est le plus court chemin entre ces deux points.
    """
    return dict(nx.all_pairs_shortest_path(G))


def getLengthShortestPathDict(G: nx.Graph) -> dict:
    """Un dictionnaire dont les cles est le point d'origine et l'élément est un dictionnaire dont les cles sont les points d'arrivés et la valeur est la longueur entre chaque couple de points
    """
    return dict(nx.all_pairs_shortest_path_length(G))


def getLengthShortestPathList(G: nx.Graph) -> list:
    """Une liste avec l'ensemble des longueurs des plus courts chemins"""
    shortestPathLength = getLengthShortestPathDict(G)
    listShortestPathLength = []
    for _, dict in shortestPathLength.items():
        for _, length in dict.items():
            listShortestPathLength.append(length)
    return listShortestPathLength


def plotShortestPathHist(G: nx.Graph) -> None:
    listShortestPathLength = getLengthShortestPathList(G)
    n_bins = 10
    fig = plt.figure()
    # fig.suptitle("Distribution des longueurs des plus courts chemins")
    plt.hist(listShortestPathLength, bins=n_bins)


def getNumberShortestPath(G: nx.Graph) -> int:
    return len(getLengthShortestPathList(G))

def getAvgShortestPathLength(G: nx.Graph) -> int:
    listShortestPathLength = getLengthShortestPathList(G)
    return sum(listShortestPathLength) / len(listShortestPathLength)


def plotShortestPath(G: nx.Graph) -> None:
    pos = nx.get_node_attributes(G, 'pos')
    shortestPath = getShortestPath(G)
    fig = plt.figure()
    # fig.suptitle("Plus courts chemins de satellites")
    ax = fig.add_subplot(projection='3d')
    ax.view_init(elev=40, azim=-130)

    maxLength = max(getLengthShortestPathList(G))
    colors = plt.get_cmap('hsv', maxLength)
    for _, dict in shortestPath.items():
        for _, path in dict.items():
            length = len(path)
            if length <= 1:
                continue
            else:
                edge = np.array([(pos[path[k]], pos[path[k+1]])
                                for k in range(length-1)])
                for vizedge in edge:
                    ax.plot(*vizedge.T, color=colors(length))

    #pos = nx.get_node_attributes(G, 'pos')
    node_xyz = np.array([pos[n] for n in G.nodes()])
    ax.scatter(*node_xyz.T, c='gray')
    # retirer les labels
    ax.set_xticklabels([])
    ax.set_yticklabels([])
    ax.set_zticklabels([])

# partie 3

def getWeightedGraph(points: list, reach: int) -> nx.Graph:
    G = nx.Graph()
    for i in range(len(points)):
        xi = points[i][0]
        yi = points[i][1]
        zi = points[i][2]
        G.add_node(i, pos=(xi, yi, zi))
        for j in range(len(points)):
            if i == j:
                continue
            xj = points[j][0]
            yj = points[j][1]
            zj = points[j][2]
            dist2 = (xi-xj)**2 + (yi-yj)**2 + (zi-zj)**2
            if dist2 <= reach**2:
                G.add_edge(i, j, weight=dist2)
    return G

def getShortestWeightedPath(G: nx.Graph) -> dict:
    """Un dictionnaire dont les cles est le point d'origine et l'élément est un dictionnaire dont les cles sont les points d'arrivés et la valeur est le plus court chemin entre ces deux points.
    """
    return dict(nx.all_pairs_dijkstra_path(G))


def getLengthShortestWeightedPathDict(G: nx.Graph) -> dict:
    """Un dictionnaire dont les cles est le point d'origine et l'élément est un dictionnaire dont les cles sont les points d'arrivés et la valeur est la longueur entre chaque couple de points
    """
    return dict(nx.all_pairs_dijkstra_path_length(G))


def getLengthShortestWeightedPathList(G: nx.Graph) -> list:
    """Une liste avec l'ensemble des longueurs des plus courts chemins"""
    shortestPathLength = getLengthShortestWeightedPathDict(G)
    listShortestPathLength = []
    for _, dict in shortestPathLength.items():
        for _, length in dict.items():
            listShortestPathLength.append(length)
    return listShortestPathLength


def plotShortestWeightedPathHist(G: nx.Graph) -> None:
    listShortestPathLength = getLengthShortestWeightedPathList(G)
    n_bins = 10
    fig = plt.figure()
    # fig.suptitle("Distribution des longueurs des plus courts chemins")
    plt.hist(listShortestPathLength, bins=n_bins)


# def plotShortestWeightedPath(G: nx.Graph) -> None:
#     pos = nx.get_node_attributes(G, 'pos')
#     labels = nx.get_edge_attributes(G, 'weight')
#     print(labels)
#     shortestPath = getShortestWeightedPath(G)
#     fig = plt.figure()
#     # fig.suptitle("Plus courts chemins de satellites")
#     ax = fig.add_subplot(projection='3d')
#     ax.view_init(elev=40, azim=-130)

#     # maxLength = max(getLengthShortestWeightedPathList(G))
#     # colors = plt.get_cmap('hsv', maxLength)
#     for _, dict in shortestPath.items():
#         for _, path in dict.items():
#             length = len(path)
#             if length <= 1:
#                 continue
#             else:
#                 label_edge = np.array()
#                 edge = np.array([(pos[path[k]], pos[path[k+1]])
#                                 for k in range(length-1)])
#                 for vizedge in edge:
#                     ax.plot(*vizedge.T, label="")

#     node_xyz = np.array([pos[n] for n in G.nodes()])
#     ax.scatter(*node_xyz.T, c='gray')
#     # retirer les labels
#     ax.set_xticklabels([])
#     ax.set_yticklabels([])
#     ax.set_zticklabels([])

DATA_FOLDER: str = "./data/"
IMG_FOLDER: str = "./doc/img/"

REACHES: list[int] = [20_000, 40_000, 60_000]  # en km
DENSITIES: list[str] = ["low", "avg", "high"]

PLOT_FUNCTIONS: list[callable, str] = [
    [plotGraph, "graph"],
    [plotDegrees, "degrees"],
    [plotDegreeHist, "degree-hist"],
    [plotClusteringDegrees, "clustering-degrees"],
    [plotClusteringDegreeHist, "clustering-degree-hist"],
    [plotCliques, "cliques"],
    [plotConnectedComponents, "connected-components"],
    [plotShortestPathHist, "shortest-path-hist"],
    [plotShortestPath, "shortest-path"]
]

CALCULATIONS: list[callable, str] = [
    [getAvgDegree, "average degree"],
    [getAvgClusteringDegree, "average clustering degree"],
    [getNumberCliques, "number of cliques"],
    [getNumberConnectedComponents, "number of connected components"],
    [getNumberShortestPath, "number of shortest paths"],
    [getAvgShortestPathLength, "average shortest path length"]]


def plots():
    debutTime = time.time()
    numToPlot = len(DENSITIES) * len(REACHES) * len(PLOT_FUNCTIONS)
    numPlotted = 0
    os.system(f"mkdir {IMG_FOLDER}")
    for density in DENSITIES:
        print(f"Processing {density} density")
        # remove and create the directory
        os.system(f"rm -rf {IMG_FOLDER}/{density}")
        os.system(f"mkdir {IMG_FOLDER}/{density}")
        filename: str = f"{DATA_FOLDER}topology_{density}.csv"
        points = readCSV(filename)
        plotPoints(points)
        plt.savefig(f"{IMG_FOLDER}/{density}/points.png", bbox_inches='tight')
        plt.close()
        for reach in REACHES:
            path: str = f"{IMG_FOLDER}/{density}"
            G: nx.Graph = getGraph(points, reach)
            for function, name in PLOT_FUNCTIONS:
                function(G)
                plt.savefig(f"{path}/{name}_{reach}.png", bbox_inches='tight')
                plt.close()
                numPlotted += 1
                print(f"{(numPlotted / numToPlot) * 100:.2f}% plots done")
        print(f"Done processing {density} density")
    print("Done processing all densities")
    endTime = time.time()
    print(f"Execution time: {endTime - debutTime:.2f} seconds")


def calculations():
    for density in DENSITIES:
        print(f"{density} density")
        filename: str = f"{DATA_FOLDER}topology_{density}.csv"
        points = readCSV(filename)
        for reach in REACHES:
            print(f"| {reach}km")
            G: nx.Graph = getGraph(points, reach)
            for function, name in CALCULATIONS:
                print(f"| | {name}: {function(G):.2f}")


def main():
    parser = argparse.ArgumentParser(description="Process some graphs.")
    parser.add_argument(
        'action',
        choices=['p', 'c'],
        help="Action to perform: 'p' to generate plots or 'c' to perform calculations")
    args = parser.parse_args()

    if args.action == 'p':
        plots()
    elif args.action == 'c':
        calculations()


if __name__ == "__main__":
    main()
