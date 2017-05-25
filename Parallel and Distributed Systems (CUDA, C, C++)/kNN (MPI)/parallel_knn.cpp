/*
  parallel_mavrodis.cpp

  This program implements a simple version of a k-nn search algorithm,
  a 1-nn algorithm to be more accurate. It breaks the problem
  into smaller parts and uses MPI to implement the communications.


  Author: <Konstantinos Mavrodis>
  Contact: <kmavrodis@outlook.com>
*/

#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <ctime>
#include <cstdlib>
#include <vector>
#include <math.h>
#include <algorithm> 
#include <time.h>
#include <fstream>


#include <mpi.h>

#define TESTING false

struct Point
{
  double x,y,z;
};

class Box
{
public:
  int id;
  double xStart, yStart, zStart;
public:
  std::vector<Point> cElements;
  std::vector<Point> qElements;

  Box(int _id, double _xStart, double _yStart, double _zStart)
  {
    id = _id; xStart = _xStart; yStart = _yStart; zStart = _zStart;
  }
  ~Box() {};
};


class Cube
{
public:
  int nC, nQ, n, m, k, P;
  int processID;
  double xStep, yStep, zStep;
  Box *boxArray;
  int nCutsSubGridX,nCutsSubGridY,nCutsSubGridZ;
  int mySubGridX, mySubGridY, mySubGridZ;
  std::vector<int> myBoxesIDs;
  double *serializedArray;
  double *receivedArray;
  int serializedArraySize;

public:
  Cube(int, const char**, int, int);
  ~Cube() {};
  void createGrid();
  void generatePoints();
  int getID(int stepsOnX, int stepsOnY, int stepsOnZ);
  void searchNearestNeighbors();
  bool isInRange(int x, int y, int z);
  double distance(struct Point pointA, struct Point pointB);
  void createBoxSubGrid();
  void sendPoints();
  void receivePoints();
  void serializeArray();
  void deserializeArray();
  void checkResults(struct Point point, int i, int j, double myDistance);
};


Cube::Cube(int argc, const char **argv, int NumTasks, int SelfTID)
{
  P = NumTasks;
  processID = SelfTID;

  if (argc == 6)
  {
    nC = 1<<atoi(argv[1]);
    nQ = 1<<atoi(argv[2]);
    n  = 1<<atoi(argv[3]);
    m  = 1<<atoi(argv[4]);
    k  = 1<<atoi(argv[5]);
  }
  else
  {
    nC = 1<<(22);
    nQ = 1<<(22);
    n  = 1<<(4);
    m  = 1<<(4);
    k  = 1<<(5);
  }

  xStep = 1/(double)n;
  yStep = 1/(double)m;
  zStep = 1/(double)k;

  boxArray = (Box*) malloc(n*m*k * sizeof(Box));
}

void Cube::createGrid()
{
  int id = 0;
  double xStart, yStart, zStart;
  xStart = 0;
  for (int nn = 0; nn < n; ++nn)
  {
    yStart = 0;
    for (int mm = 0; mm < m; ++mm)
    {
      zStart = 0;
      for (int kk = 0; kk < k; ++kk)
      {
        Box newBox(id, xStart, yStart, zStart);
        boxArray[id] = newBox;

        id++;
        zStart += zStep;
      }
      yStart += yStep;
    }
    xStart += xStep;
  }
}

void Cube::createBoxSubGrid()
{
  nCutsSubGridX = nCutsSubGridY = nCutsSubGridZ = 1;
  while(nCutsSubGridX*nCutsSubGridY*nCutsSubGridZ < P)
  {
    nCutsSubGridZ = nCutsSubGridZ * 2;
    if (nCutsSubGridX*nCutsSubGridY*nCutsSubGridZ >= P)
      break;
    nCutsSubGridY = nCutsSubGridY * 2;
    if (nCutsSubGridX*nCutsSubGridY*nCutsSubGridZ >= P)
      break;
    nCutsSubGridX = nCutsSubGridX * 2;
  }

  mySubGridX = mySubGridY = mySubGridZ = 0;

  for (int i = 0; i < processID; ++i)
  {
    mySubGridZ++;
    if (mySubGridZ == nCutsSubGridZ)
    {
      mySubGridZ = 0;
      mySubGridY++;
      if (mySubGridY == nCutsSubGridY)
      {
        mySubGridY = 0;
        mySubGridX++;
      }
    }
  }

  for (int i = 0; i < n*m*k; ++i)
  {
    if ((mySubGridX*(1/(double)nCutsSubGridX) <= boxArray[i].xStart && 
      mySubGridX*(1/(double)nCutsSubGridX)+(1/(double)nCutsSubGridX) > boxArray[i].xStart) &&
      (mySubGridY*(1/(double)nCutsSubGridY) <= boxArray[i].yStart && 
      mySubGridY*(1/(double)nCutsSubGridY)+(1/(double)nCutsSubGridY) > boxArray[i].yStart) &&
      (mySubGridZ*(1/(double)nCutsSubGridZ) <= boxArray[i].zStart && 
      mySubGridZ*(1/(double)nCutsSubGridZ)+(1/(double)nCutsSubGridZ) > boxArray[i].zStart))
      {
        myBoxesIDs.push_back(i);
      }
  }
}

void Cube::generatePoints()
{
  srand(time(NULL)*(processID+1));

  for (int i = 0; i < nC/P; ++i)
  {
    Point point;
    point.x = ((long double)rand()+1)/((long double)RAND_MAX+1);
    point.y = ((long double)rand()+1)/((long double)RAND_MAX+1);
    point.z = ((long double)rand()+1)/((long double)RAND_MAX+1);

    int stepsOnX = point.x/xStep;
    int stepsOnY = point.y/yStep;
    int stepsOnZ = point.z/zStep;

    boxArray[getID(stepsOnX, stepsOnY, stepsOnZ)].cElements.push_back(point);
  }

  for (int i = 0; i < nQ/P; ++i)
  {
    Point point;
    point.x = ((long double)rand()+1)/((long double)RAND_MAX+1);
    point.y = ((long double)rand()+1)/((long double)RAND_MAX+1);
    point.z = ((long double)rand()+1)/((long double)RAND_MAX+1);

    int stepsOnX = point.x/xStep;
    int stepsOnY = point.y/yStep;
    int stepsOnZ = point.z/zStep;

    boxArray[getID(stepsOnX, stepsOnY, stepsOnZ)].qElements.push_back(point);
  } 
}

void Cube::sendPoints()
{  
  serializeArray();

  int *sdisp,*scounts,*rdisp,*rcounts;
  int ssize,rsize,i,k,j;

  scounts=(int*)malloc(sizeof(int)*P);
  rcounts=(int*)malloc(sizeof(int)*P);
  sdisp=(int*)malloc(sizeof(int)*P);
  rdisp=(int*)malloc(sizeof(int)*P);

  for (int i = 0; i < P; ++i)
  {
    scounts[i] = serializedArraySize;
    sdisp[i] = 0;  
  }
  
  rdisp[0] = 0;
  for (int i = 1; i < P; ++i)
  {
    rdisp[i] = rdisp[i-1] + serializedArraySize; 
  }

  MPI_Alltoall(scounts,1, MPI_INT, rcounts,1,MPI_INT, MPI_COMM_WORLD);

  receivedArray = (double*)malloc(sizeof(double)*(P*serializedArraySize));

  MPI_Alltoallv(serializedArray,scounts, sdisp, MPI_DOUBLE, 
                receivedArray, rcounts, rdisp, MPI_DOUBLE, MPI_COMM_WORLD); 
}

void Cube::receivePoints()
{
  for (int i = 0; i < n*m*k; ++i)
  {
    boxArray[i].cElements.clear();
    boxArray[i].qElements.clear();
  }

  deserializeArray();
}

void Cube::serializeArray()
{
  serializedArraySize = 0;
  for (int i = 0; i < n*k*m; ++i)
  {
    for (int j = 0; j < boxArray[i].cElements.size(); ++j)
    {      
      serializedArraySize = serializedArraySize + 3;
    }
    serializedArraySize++;
  }

  for (int i = 0; i < n*k*m; ++i)
  {
    for (int j = 0; j < boxArray[i].qElements.size(); ++j)
    {      
      serializedArraySize = serializedArraySize + 3;
    }
    serializedArraySize++;
  }

  serializedArray = (double *)malloc(serializedArraySize * sizeof(double));

  int it = 0;
  for (int i = 0; i < n*k*m; ++i)
  {
    for (int j = 0; j < boxArray[i].cElements.size(); ++j)
    {      
      serializedArray[it++] = boxArray[i].cElements[j].x;
      serializedArray[it++] = boxArray[i].cElements[j].y;
      serializedArray[it++] = boxArray[i].cElements[j].z;
    }
    serializedArray[it++] = -1;
  }
  for (int i = 0; i < n*k*m; ++i)
  {
    for (int j = 0; j < boxArray[i].qElements.size(); ++j)
    {      
      serializedArray[it++] = boxArray[i].qElements[j].x;
      serializedArray[it++] = boxArray[i].qElements[j].y;
      serializedArray[it++] = boxArray[i].qElements[j].z;
    }
    serializedArray[it++] = -1;
  }
}

void Cube::deserializeArray()
{
  int it = 0;
  for (int process = 0; process < P; ++process)
  {
    for (int i = 0; i < n*m*k; ++i)
    {
      while (true)
      {
        if(receivedArray[it] == -1)
        {
          it++;
          break;
        }
        Point point;
        point.x = receivedArray[it++];
        point.y = receivedArray[it++];
        point.z = receivedArray[it++];
        boxArray[i].cElements.push_back(point);
      }
    }
  }
  for (int process = 0; process < P; ++process)
  {
    for (int i = 0; i < n*m*k; ++i)
    {
      while (true)
      {
        if(receivedArray[it] == -1)
        {
          it++;
          break;
        }
        Point point;
        point.x = receivedArray[it++];
        point.y = receivedArray[it++];
        point.z = receivedArray[it++];
        boxArray[i].qElements.push_back(point);
      }
    }
  }
}

void Cube::searchNearestNeighbors()
{
  for (int i = 0; i < (n*m*k); ++i)
  {
    if (std::find(myBoxesIDs.begin(), myBoxesIDs.end(), i) != myBoxesIDs.end())
    {
      std::vector<Box> boxesToSearch;

      int x = boxArray[i].xStart / xStep;
      int y = boxArray[i].yStart / yStep;
      int z = boxArray[i].zStart / zStep;
      
      for (int a = -1; a < 2; ++a)
      {
        for (int b = -1; b < 2; ++b)
        {
          for (int c = -1; c < 2; ++c)
          {
            if (isInRange(x+a, y+b, z+c))
              boxesToSearch.push_back(boxArray[getID(x+a, y+b, z+c)]);
          }
        }
      }

      for (int j = 0; j < boxArray[i].qElements.size(); ++j)
      {
        double minDistance = 1;
        for (int w = 0; w < boxesToSearch.size(); ++w)
        {
          for (int u = 0; u < boxesToSearch[w].cElements.size(); ++u)
          {
            if (distance(boxArray[i].qElements[j], boxesToSearch[w].cElements[u]) < minDistance)
              minDistance = distance(boxArray[i].qElements[j], boxesToSearch[w].cElements[u]);
          }
        }
        if (TESTING == true && rand()%100 == 0)
          checkResults (boxArray[i].qElements[j], i, j, minDistance);
        //std::cout << minDistance <<std::endl;
      }  
    }
  }    
}

void Cube::checkResults(struct Point point, int i, int j, double myDistance)
{
  // Checks by BruteForce correctness
  double minDistance = 1;
  for (int i = 0; i < n*m*k; ++i)
  {
    for (int j = 0; j < boxArray[i].cElements.size(); ++j)
    {
      if (minDistance >= distance(boxArray[i].cElements[j], point))
        minDistance = distance(boxArray[i].cElements[j], point);
    }
  }
  if (minDistance != myDistance)
    printf("FALSE\n");
}

int Cube::getID(int stepsOnX, int stepsOnY, int stepsOnZ)
{
  return (stepsOnX*(m*k) + stepsOnY*k + stepsOnZ);
}


bool Cube::isInRange(int x, int y, int z)
{
  if (x < 0 || y < 0 || z < 0)
    return false;
  if (x >= n || y >= m || z >= k)
    return false;
  return true;
}

double Cube::distance(struct Point pointA, struct Point pointB)
{
  return sqrt((pointA.x-pointB.x)*(pointA.x-pointB.x) + 
    (pointA.y-pointB.y)*(pointA.y-pointB.y) + 
    (pointA.z-pointB.z)*(pointA.z-pointB.z));
}


int main(int argc, char const **argv)
{
  int SelfTID, NumTasks, t, data, err;
  MPI_Status mpistat;

  err = MPI_Init( NULL, NULL );

  if (err) 
  {
    printf("Error=%i in MPI_Init\n",err);
  }

  MPI_Comm_size( MPI_COMM_WORLD, &NumTasks );
  MPI_Comm_rank( MPI_COMM_WORLD, &SelfTID );
  
  MPI_Barrier(MPI_COMM_WORLD);
  if(SelfTID == 0)
    clock_t t = clock(); 

  Cube cube(argc, argv, NumTasks, SelfTID);

  cube.createGrid();

  cube.createBoxSubGrid();

  cube.generatePoints();

  cube.sendPoints();

  cube.receivePoints();

  cube.searchNearestNeighbors();


  MPI_Barrier(MPI_COMM_WORLD);

  if(SelfTID == 0)
  {
    t = clock() - t;

    printf ("%i %i %i %i %i %i %f\n", (int)log2(cube.nC), 
      (int)log2(cube.nQ), (int)log2(cube.n), (int)log2(cube.m),
      (int)log2(cube.k), cube.P, ((float)t)/CLOCKS_PER_SEC);
  }
 
  MPI_Finalize();

  return 0;
}