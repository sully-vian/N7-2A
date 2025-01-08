import csv
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
    plt.show()

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

def plotDegree(points:list, reach:int):
    degrees = getDegrees(points, reach)
    fig = plt.figure()
    ax = fig.add_subplot(projection='3d')
    xs = [point[0] for point in points]
    ys = [point[1] for point in points]
    zs = [point[2] for point in points]
    ax.scatter(xs, ys, zs, c=degrees, cmap='jet')
    plt.show()

def plotDegreeHist(points:list, reach:int):
    degrees = getDegrees(points, reach)
    n_bins = 10
    plt.hist(degrees, bins=n_bins)
    plt.show()

points = readCSV("./topology_high.csv")

plotDegreeHist(points, 60_000)
