####### Diakrita - Ergasia B - Part A
####### Konstantinos Mavrodis

matrix = []

### Swaps two columns and rows at the same time
def swap(x, y) :    
    for i in range(0, len(matrix)) :
        matrix[x][i], matrix[y][i] = matrix[y][i], matrix[x][i]
    for j in range(0, len(matrix)) :
        matrix[j][x], matrix[j][y] = matrix[j][y], matrix[j][x]


### Open and read the input file
inputFile = open("input.txt", "r")
outputFile = open("output.txt", "w+")
for line in inputFile :
    matrix.append(map(int, line.split()))


### Main Algorithm
nextPosition = 0;
for i in range(0, len(matrix)) :
    if nextPosition == i :
        nextPosition += 1
    for j in range(0, len(matrix)) :        
        if matrix[i][j] == 1 and j > i and nextPosition < j:
            swap(nextPosition, j)
            nextPosition += 1


### Save to Output File
for i in range(0, len(matrix)) :
        aLine = str(matrix[i]).replace(',', '').replace('[', '').replace(']', '') + "\n"
        outputFile.write(aLine)
outputFile.close