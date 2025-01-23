import networkx as nx
import numpy as np
import matplotlib.pyplot as plt
import csv

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


def getGraph(points: list, reach: int):
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

def plotGraph(points: list, reach: int):
    G = getGraph(points, reach)
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


def getDegrees(points:list, reach:int):
    G = getGraph(points, reach)
    degreesPerNode=list(G.degree([i for i in range(len(G.nodes))]))
    return [v for _,v in degreesPerNode]

def getAvgDegree(points:list, reach:int):
    degrees = getDegrees(points,reach)

    return sum(degrees) / len(degrees)

def plotDegrees(points:list, reach:int):
    degrees = getDegrees(points, reach)
    fig = plt.figure()
    ax = fig.add_subplot(projection='3d')
    xs = [point[0] for point in points]
    ys = [point[1] for point in points]
    zs = [point[2] for point in points]
    ax.scatter(xs, ys, zs, c=degrees, cmap='jet')

def plotDegreeHist(points:list, reach:int):
    degrees = getDegrees(points, reach)
    n_bins = 10
    plt.figure()
    plt.hist(degrees, bins=n_bins)

def getLocalClusteringDegrees(points:list, reach: int):
    G = getGraph(points, reach)
    d = getDegrees(points, reach)
    numTriangles = nx.triangles(G)
    return [numTriangles[i] / (d[i]*(d[i]-1) / 2) if d[i] > 1 else 0 for i in range(len(G.nodes()))]

def plotClusteringDegrees(points:list, reach:int):
    clustDeg = getLocalClusteringDegrees(points, reach)
    fig = plt.figure()
    ax = fig.add_subplot(projection='3d')
    xs = [point[0] for point in points]
    ys = [point[1] for point in points]
    zs = [point[2] for point in points]
    ax.scatter(xs, ys, zs, c=clustDeg, cmap='jet')

def plotClusteringDegreeHist(points:list, reach:int):
    clusteringDegrees = getLocalClusteringDegrees(points, reach)
    n_bins = 10
    plt.figure()
    plt.hist(clusteringDegrees, bins=n_bins)

def getCliques(points: list, reach: int):
    G = getGraph(points, reach)
    allCliques = list(nx.find_cliques(G))
    return allCliques

def plotCliques(points:list, reach:int):
    G = getGraph(points, reach)
    pos=nx.get_node_attributes(G, 'pos')
    #plotGraph(points, reach)

    cliques = getCliques(points, reach)
    fig = plt.figure()
    ax = fig.add_subplot(projection='3d')
    # colormap that streatches from 0 to len(cliques)
    colors = plt.get_cmap('hsv', len(cliques))
    for k in range(len(cliques)):
        clique = cliques[k]
        if len(clique) == 1:
            continue
        elif len(clique) == 2:
            

        for i in clique:
            for j in clique:
                if (i==j):
                    continue
                xi = points[i][0]
                yi = points[i][1]
                zi = points[i][2]
                xj = points[j][0]
                yj = points[j][1]
                zj = points[j][2]
                ax.plot([xi, xj], [yi, yj], [zi, zj], color=colors(k))
    xs = [point[0] for point in points]
    ys = [point[1] for point in points]
    zs = [point[2] for point in points]
    ax.scatter(xs, ys, zs, c='gray')

points = readCSV("./topology_low.csv")
plotCliques(points, 20_000)
plotGraph(points, 20000)
print(getCliques(points, 20_000))

plt.show()