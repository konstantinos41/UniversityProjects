/**
* Isomorphic matrices checker
* Developed by Konstantinos Mavrodis
*/

#include <stdio.h>
#include <time.h>
#include <stdlib.h>


int n = 0;
char **tableA;
char **tableB;

int compare()
{
  int i, j;
  for (i = 0; i < n; ++i)
    for (j = 0; j < n; ++j)
        if ( i >= j && tableA[i][j] != tableB[i][j])
          return 0;
  return 1;
}


int swapCollWithRow(int x1, int x2)
{
  int i, t;

  for (i = 0; i < n; ++i)
  {
    t = tableA[x1][i];
    tableA[x1][i] = tableA[x2][i];
    tableA[x2][i] = t;
  }

  for (i = 0; i < n; ++i)
  {
    t = tableA[i][x1];
    tableA[i][x1] = tableA[i][x2];
    tableA[i][x2] = t;
  }
  return 1;
}



int main()
{
  clock_t start, stop;
  start = clock();

  FILE *inputFile;
  inputFile = fopen("input.txt", "r");
  FILE *outputFile;
  outputFile = fopen("output.txt", "w");

  char *line = NULL;
  size_t len = 0;
  ssize_t read;

  int counter = 0;
  int i = 0;
  while ((read = getline(&line, &len, inputFile)) != -1)
  {
    if (counter == 0)
    {
      n = atoi (line);

      tableA = (char **)malloc(n * sizeof(char *));
      for (i = 0; i < n; i++)
        tableA[i] = (char *)malloc(n * sizeof(char));

      tableB = (char **)malloc(n * sizeof(char *));
      for (i = 0; i < n; i++)
        tableB[i] = (char *)malloc(n * sizeof(char));
    }

    else if (counter > 1 && counter < n + 2)
    {
      for (i = 0; i < n; i++)
        tableA[counter-2][i] = line[2 * i];
    }

    else if (counter > n + 2 && counter < 2*n + 4)
    {
      for (i = 0; i < n; i++)
        tableB[counter-n-3][i] = line[2 * i];
    }
    counter++;
  }
  fclose(inputFile);

  int *helperArray;
  helperArray = (int *)malloc((n+1) * sizeof(int));
  int j;

  for (i = 0; i < n+1; i++)
    helperArray[i] = i;

  i = 1;
  while (i < n)
  {
    helperArray[i]--;

    if (i%2 == 1)
      j = helperArray[i];
    else
      j = 0;

    swapCollWithRow(j, i);

    if (compare() == 1)
    {
      fprintf(outputFile, "Isomorphic\n");
      goto stopLabel;
    }

    i = 1;
    while (helperArray[i] == 0)
    {
      helperArray[i] = i;
      i++;
    }
  }
  fprintf(outputFile, "NON Isomorphic\n");


  stopLabel:
  stop = clock();
  float timePassed = (float)(stop - start) / CLOCKS_PER_SEC;

  fprintf(outputFile, "Time measured is %f.", timePassed);

  fclose(outputFile);

  return 1;
}
