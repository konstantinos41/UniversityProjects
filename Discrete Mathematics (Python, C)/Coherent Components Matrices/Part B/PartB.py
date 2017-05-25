####### Diakrita - Ergasia B - Part B
####### Konstantinos Mavrodis

matrix = []

def rowSwap(x, y) :
    for i in range(0, len(matrix[x])) :
        matrix[x][i], matrix[y][i] = matrix[y][i], matrix[x][i]

def columnSwap(x,y) :
    for j in range(0, len(matrix)) :
            matrix[j][x], matrix[j][y] = matrix[j][y], matrix[j][x]


### Open and read the input file
inputFile = open("input.txt", "r")

for line in inputFile :
    matrix.append(map(int, line.split()))

inputFile.close


### Main Algorithm
nextPosition = 0
for i in range(0, len(matrix)) :
    if nextPosition == i :
        nextPosition += 1
    for j in range(0, len(matrix[i])) :
        if matrix[i][j] == 1 :
            for k in range(i+1, len(matrix)) :
                if matrix[k][j] == 1 and nextPosition < k :
                    rowSwap(nextPosition, k)
                    nextPosition += 1


nextPosition = 0
for i in range(0, len(matrix)) :     
    for j in range(i, len(matrix[i])) :  
        if matrix[i][j] == 1 and nextPosition <= j:
            columnSwap(j, nextPosition)
            nextPosition += 1
    


### Save to Output File
outputFile = open("output.txt", "w+")
for i in range(0, len(matrix)) :
        aLine = str(matrix[i]).replace(',', '').replace('[', '').replace(']', '') + "\n"
        outputFile.write(aLine)
outputFile.close