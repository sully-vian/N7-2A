import csv
import matplotlib as mp
import matplotlib.pyplot as plt

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

def getAdjMatrix(points: list, reach:int):
    m = [[0 for i in range(len(points))] for i in range(len(points))]

    for i in range(len(points)):
        xi = points[i][0]
        yi = points[i][1]
        zi = points[i][2]
        for j in range(len(points)):
            if i == j:
                continue
            xj = points[j][0]
            yj = points[j][1]
            zj = points[j][2]
            dist2 = (xi-xj)**2 + (yi-yj)**2 + (zi-zj)**2
            if dist2 <= reach**2:
                m[i][j] = 1
    return m

def plotGraph(points: list, reach:int):
    m = getAdjMatrix(points, reach)
    fig = plt.figure()
    ax = fig.add_subplot(projection='3d')
    for i in range(len(points)):
        for j in range(0,i):
            if m[i][j]:
                xi = points[i][0]
                yi = points[i][1]
                zi = points[i][2]
                xj = points[j][0]
                yj = points[j][1]
                zj = points[j][2]
                ax.plot([xi, xj], [yi, yj], [zi, zj], color='gray')
    plt.show()

def getDegrees(points:list, reach:int):
    m = getAdjMatrix(points, reach)
    degrees = [0 for i in range(len(points))]
    for i in range(len(points)):
        for j in range(len(points)):
            degrees[i] += m[i][j]
    return degrees

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

def getLocalClusteringDegrees(points:list, reach:int):
    n = len(points)
    m = getAdjMatrix(points, reach)
    d = getDegrees(points, reach)
    numTriangles = [0 for i in range(len(points))]
    triangleTot = 0
    for i in range(n):
        for j in range(i+1,n):
            for k in range(j+1,n):
                if (m[i][j] * m[j][k] * m[k][i]):
                    triangleTot += 1
                    numTriangles[i] += 1
                    numTriangles[j] += 1
                    numTriangles[k] += 1
    res = [numTriangles[i] / (d[i]*(d[i]-1) / 2) if d[i] > 1 else 0 for i in range(n)]
    return res

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

def getCliques(points:list, reach:int):
    m = getAdjMatrix(points, reach)
    cliques = [[0]]
    for i in range(1,len(points)):
        added = False
        for clique in cliques:
            # vérifier si i appartient à la clique
            inClique = True
            for point in clique:
                if (not m[i][point]):
                    inClique = False
                    break
            if inClique:
                clique.append(i)
                added = True
        if not added:
            # nouvelle clique avec i tout seul
            cliques.append([i])
    return cliques

def plotCliques(points:list, reach:int):
    cliques = getCliques(points, reach)
    fig = plt.figure()
    ax = fig.add_subplot(projection='3d')
    # colormap that streatches from 0 to len(cliques)
    colors = plt.get_cmap('hsv', len(cliques))
    for k in range(len(cliques)):
        clique = cliques[k]
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

def getConnectedComponents(points:list, reach:int):
    m = getAdjMatrix(points, reach)
    connectedComponents = [[0]]
    for i in range(1,len(points)):
        added = False
        for connectedComponent in connectedComponents:
            # vérifier si i appartient à la composante connexe
            inComponent = False
            for point in connectedComponent:
                if (m[i][point]):
                    inComponent = True
                    break
            if inComponent:
                connectedComponent.append(i)
                added = True
                break
        if (not added):
            connectedComponents.append([i])
    return connectedComponents

def plotConnectedComponents(points:list, reach:int):
    m = getAdjMatrix(points, reach)
    connectedComponents = getConnectedComponents(points, reach)
    fig = plt.figure()
    ax = fig.add_subplot(projection='3d')
    # colormap that streatches from 0 to len(cliques)
    colors = plt.get_cmap('hsv', len(connectedComponents))
    for k in range(len(connectedComponents)):
        clique = connectedComponents[k]
        for i in clique:
            for j in clique:
                if (i==j or not m[i][j]):
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
print(len(getCliques(points, 20000)))
# plotConnectedComponents(points, 20_000)
# plotConnectedComponents(points, 40_000)
# plotConnectedComponents(points, 60_000)
plt.show()