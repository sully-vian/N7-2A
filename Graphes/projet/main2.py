import networkx as nx
import numpy as np
import matplotlib.pyplot as plt
import csv
import random
from itertools import combinations

def readCSV(filename: str):
    with open(filename, newline='') as csvfile:
        spamreader = csv.reader(csvfile, delimiter=',')
        datalist = list(spamreader)
        points = []
        for row in datalist[1:]:
            x = float(row[1])
            y = float(row[2])
            z = float(row[3])
            points.append([x,y,z])
    return points

def plotPoints(points: list):
    fig = plt.figure()
    ax = fig.add_subplot(projection='3d')
    xs = [point[0] for point in points]
    ys = [point[1] for point in points]
    zs = [point[2] for point in points]
    ax.scatter(xs, ys, zs)


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
                G.add_edge(i,j)
    return G

def plotGraph(G : nx.Graph):
    pos=nx.get_node_attributes(G, 'pos')
    node_xyz = np.array([pos[n] for n in G.nodes()])
    edge_xyz = np.array([(pos[u], pos[v]) for u,v in G.edges()])

    # Create the 3D figure
    fig = plt.figure()
    ax = fig.add_subplot(projection="3d")
    ax.scatter(*node_xyz.T)

    # Plot the edges
    for vizedge in edge_xyz:
        ax.plot(*vizedge.T, color="tab:gray")


def getDegrees(G : nx.Graph) -> list:
    degreesPerNode=list(G.degree([i for i in range(len(G.nodes))]))
    return [v for _,v in degreesPerNode]

def getAvgDegree(G : nx.Graph) -> int:
    degrees = getDegrees(G)
    return sum(degrees) / len(degrees)

def plotDegrees(G : nx.Graph):
    degrees = getDegrees(G)
    fig = plt.figure()
    ax = fig.add_subplot(projection='3d')
    xs = [point[0] for point in points]
    ys = [point[1] for point in points]
    zs = [point[2] for point in points]
    ax.scatter(xs, ys, zs, c=degrees, cmap='jet')

def plotDegreeHist(G : nx.Graph):
    degrees = getDegrees(G)
    n_bins = 10
    plt.figure()
    plt.hist(degrees, bins=n_bins)

def getLocalClusteringDegrees(G : nx.Graph) -> list:
    d = getDegrees(G)
    numTriangles = nx.triangles(G)
    return [numTriangles[i] / (d[i]*(d[i]-1) / 2) if d[i] > 1 else 0 for i in range(len(G.nodes()))]

def plotClusteringDegrees(G : nx.Graph):
    clustDeg = getLocalClusteringDegrees(G)
    fig = plt.figure()
    ax = fig.add_subplot(projection='3d')
    xs = [point[0] for point in points]
    ys = [point[1] for point in points]
    zs = [point[2] for point in points]
    ax.scatter(xs, ys, zs, c=clustDeg, cmap='jet')

def plotClusteringDegreeHist(G : nx.Graph):
    clusteringDegrees = getLocalClusteringDegrees(G)
    n_bins = 10
    plt.figure()
    plt.hist(clusteringDegrees, bins=n_bins)

def getCliques(G : nx.Graph) -> list:
    return list(nx.find_cliques(G))

def getNumberCliques(G : nx.Graph) -> int:
    return len(getCliques(G))

def plotCliques(G : nx.Graph):
    pos=nx.get_node_attributes(G, 'pos')
    cliques = getCliques(G)
    fig = plt.figure()
    ax = fig.add_subplot(projection='3d')
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
            edge_xyz = np.array([(pos[u], pos[v]) for u,v in combinaison  if (u,v) in G.edges()])
            for vizedge in edge_xyz:
                ax.plot(*vizedge.T, color=colorsRandom[k])
    print(k)
    xs = [point[0] for point in points]
    ys = [point[1] for point in points]
    zs = [point[2] for point in points]
    ax.scatter(xs, ys, zs, c='gray')

def getConnectedComponents(G : nx.Graph) -> list:
    return list(nx.connected_components(G))

def getNumberConnectedComponents(G : nx.Graph) -> int:
    return nx.number_connected_components(G)

def plotConnectedComponents(G : nx.Graph):
    pos=nx.get_node_attributes(G, 'pos')
    connectedComponents = getConnectedComponents(G)
    fig = plt.figure()
    ax = fig.add_subplot(projection='3d')

    # colormap that streatches from 0 to len(cliques)
    colors = plt.get_cmap('hsv', getNumberConnectedComponents(G))
    k=0
    for component in connectedComponents:
        k += 1
        if len(component) == 1:
            continue
        else:
            combinaison = combinations(component, 2)
            edge_xyz = np.array([(pos[u], pos[v]) for u,v in combinaison if (u,v) in G.edges()])
            for vizedge in edge_xyz:
                ax.plot(*vizedge.T, color=colors(k))
        
    xs = [point[0] for point in points]
    ys = [point[1] for point in points]
    zs = [point[2] for point in points]
    ax.scatter(xs, ys, zs, c='gray')

def getShortestPath(G : nx.Graph) -> dict:
    return dict(nx.all_pairs_shortest_path(G))


points = readCSV("./topology_low.csv")
G = getGraph(points, 20_000)

print(getShortestPath(G))
#plotConnectedComponents(G)
#plotConnectedCompotents(points, 20_000)
plt.show()