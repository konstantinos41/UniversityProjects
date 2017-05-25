####### Diakrita-Ergasia A
####### Konstantinos Mavrodis


####### Function for checking if an expression is true ########
def checkExpression(expression_, elements_) :
  for i in range(0, len(expression_)) :
    if (expression_[i] == 1 and elements_[i] == "1"):
      return True
    elif (expression_[i] == -1 and elements_[i] == "0"):
      return True
  
  return False



####### Main Program ########
expressionsList = []
weight = None
columns = None
rows = None


####### Read the contents of the input file ########

inputFile = open("input.txt", "r")
lineNumber = -1

for line in inputFile :
  lineNumber += 1

  if (lineNumber == 0) :
    colrow = line.split()
    columns = int(colrow[0])
    rows = int(colrow[1])

  elif (lineNumber > 0 and lineNumber < rows + 1):
    expression = line.split()
    expression = map(int, expression)
    expressionsList.append(expression)

  elif (lineNumber == rows + 1) :
    weight = line.split()
    weight = map(int, weight)

inputFile.close()


number = 0
binaryNumber = bin(0)[2:].zfill(columns)
maxNumber = int(binaryNumber.replace("0", "1"), 2)
maxWeight = -1

####### Find the maximum Weight and save the corresponding vector ######
for n in range(0, maxNumber) :  
  currentWeight = 0
  binaryN = bin(n)[2:].zfill(columns)

  for i in range(0, len(weight)):
    if (checkExpression(expressionsList[i], binaryN)) :
      currentWeight += weight[i]

  if (currentWeight >= maxWeight) :
    maxWeight = currentWeight
    result = binaryN

####### Format the result ######
result = result.replace('', ' ').strip()

####### Save to File ######
outputFile = open("output.txt", "w+")
outputFile.write("Max Weight: " + str(maxWeight) + "\n")
outputFile.write("Possible Vector with max Weight: " + result)
outputFile.close()