/*
  mavrkons_apsp.cu

  All Pair Shortest Path version 2 (APSP)

  Project D

  Author: <Konstantinos Mavrodis>
  Contact: <kmavrodis@outlook.com>
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

void initialize(int *n, float *p, int *w, int argc, char const **argv);
void makeAdjacencies(float *adjacency, float *adjacencyT, int n, float p, int w);
void serialApsp(float *adjacency, float *distance, int n, float p , int w);
void cudaA(float *adjacency, float *adjacencyT, float *cudaA_distance,  int n, float p, int w);
void cudaB(float *adjacency, float *adjacencyT,float *cudaB_distance, int n, float p, int w);
void cudaC(float *adjacency, float *adjacencyT, float *cudaC_distance, int n, float p, int w);
__global__ void cudaA_kernel(float *d_cudaA_distance, float *d_cudaA_distanceT, int n, int k);
__global__ void cudaB_kernel(float *d_cudaB_distance, float *d_cudaB_distanceT, int n, int k);
__global__ void cudaC_kernel(float *d_cudaC_distance, float *d_cudaC_distanceT, int n, int k, int cellsPerThread);
int compare(float *arrayA, float *arrayB, int n);
void printMatrix (float *, int);


int main(int argc, char const **argv)
{
  int n, w;
  float p, *adjacency, *adjacencyT, *distance, *cudaA_distance, *cudaB_distance, *cudaC_distance;
  double serialTime, cudaATime, cudaBTime, cudaCTime;
  struct timespec tstart={0,0}, tend={0,0};

  initialize(&n, &p, &w, argc, argv);
  
  adjacency = (float*) malloc(n*n * sizeof(float));
  adjacencyT = (float*) malloc(n*n * sizeof(float));
  distance = (float*) malloc(n*n * sizeof(float));
  cudaA_distance = (float*) malloc(n*n * sizeof(float));
  cudaB_distance = (float*) malloc(n*n * sizeof(float));
  cudaC_distance = (float*) malloc(n*n * sizeof(float));

  makeAdjacencies(adjacency, adjacencyT, n, p, w);

  // Serial
  clock_gettime(CLOCK_MONOTONIC, &tstart);

  serialApsp(adjacency, distance, n, p, w);

  clock_gettime(CLOCK_MONOTONIC, &tend);
  serialTime = ((double)tend.tv_sec + 1.0e-9*tend.tv_nsec) -
    ((double)tstart.tv_sec + 1.0e-9*tstart.tv_nsec);


  // Cuda A
  clock_gettime(CLOCK_MONOTONIC, &tstart);  

  cudaA(adjacency, adjacencyT, cudaA_distance, n, p, w);

  clock_gettime(CLOCK_MONOTONIC, &tend);
  cudaATime = ((double)tend.tv_sec + 1.0e-9*tend.tv_nsec) - 
    ((double)tstart.tv_sec + 1.0e-9*tstart.tv_nsec);


  // Cuda B
  clock_gettime(CLOCK_MONOTONIC, &tstart);  

  cudaB(adjacency, adjacencyT, cudaB_distance, n, p, w);

  clock_gettime(CLOCK_MONOTONIC, &tend);
  cudaBTime = ((double)tend.tv_sec + 1.0e-9*tend.tv_nsec) - 
    ((double)tstart.tv_sec + 1.0e-9*tstart.tv_nsec);
  

  // Cuda C
  clock_gettime(CLOCK_MONOTONIC, &tstart);  

  cudaC(adjacency, adjacencyT, cudaC_distance, n, p, w);

  clock_gettime(CLOCK_MONOTONIC, &tend);
  cudaCTime = ((double)tend.tv_sec + 1.0e-9*tend.tv_nsec) - 
    ((double)tstart.tv_sec + 1.0e-9*tstart.tv_nsec);


  printf("n=%i p=%g w=%i\n", n, p, w);
  printf("Serial time: %f\n", serialTime);
  printf("Cuda A time: %f\n", cudaATime);
  printf("Cuda B time: %f\n", cudaBTime);
  printf("Cuda C time: %f\n", cudaCTime);


  if(compare(cudaA_distance, distance,n) && compare(cudaB_distance, distance,n)
    && (compare(cudaC_distance, distance,n)))
    printf("PASS: All algorithms ran correctly.\n");
  else
    printf("FAIL: There was a wrong result.\n");

}


void initialize(int *n, float *p, int *w, int argc, char const **argv)
{
  if (argc == 4)
  {
    *n = 1<<atoi(argv[1]);
    *p = atof(argv[2]);
    *w = atoi(argv[3]); 
  }
  else
  {
    printf("The defaults for n,p,w (7,0.7,30) will be used\n");
    *n = 128;
    *p = 0.7;
    *w = 30;
  }
}

void makeAdjacencies(float *adjacency, float *adjacencyT, int n, float p , int w)
{
  int i, j;
  time_t t;
  srand((unsigned) time(&t));

  for (i = 0; i < n*n; ++i)
    adjacency[i] = 0;


  for (i = 0; i < n; ++i)
  {
    for (j = 0; j < n; ++j)
    {
      if ((float)(rand()%1000)/1000 > p)
        adjacency[i*n+j] = INFINITY;
      else
        adjacency[i*n+j] = ((float)(rand()%1000)/1000) * w;
    }
    adjacency[i*n+i] = 0;
  }

  // Transpose adjacency and store to adjacencyT
  for (int i = 0; i < n; ++i)
  {
  	for (int j = 0; j < n; ++j)
  	{
  		adjacencyT[i*n+j] = adjacency[j*n+i];
  	}
  }
}

void serialApsp(float *adjacency, float *distance, int n, float p , int w)
{
  int i, j, k;

  for (i = 0; i < n; ++i)
    for (j = 0; j < n; ++j)
      distance[i*n+j] = adjacency[i*n+j];

  for (k = 0; k < n; ++k)
    for (i = 0; i < n; ++i)
      for (j = 0; j < n; ++j)
        if (distance[i*n+j] > distance[i*n+k] + distance[k*n+j])
          distance[i*n+j] = distance[i*n+k] + distance[k*n+j];
}



void cudaA(float *adjacency, float *adjacencyT, float *cudaA_distance, int n, float p, int w)
{
  float *d_cudaA_distance;
  float *d_cudaA_distanceT;

  cudaMalloc(&d_cudaA_distance, n*n*sizeof(float));
  cudaMalloc(&d_cudaA_distanceT, n*n*sizeof(float));

  cudaMemcpy(d_cudaA_distance, adjacency, n*n*sizeof(float), cudaMemcpyHostToDevice);
  cudaMemcpy(d_cudaA_distanceT, adjacencyT, n*n*sizeof(float), cudaMemcpyHostToDevice);

  
  dim3 threadsPerBlock; 
  dim3 blocksPerGrid;

  threadsPerBlock.x = threadsPerBlock.y = 32;
  blocksPerGrid.x = blocksPerGrid.y = n/32;

  int k;
  for (k = 0; k < n; ++k)
    cudaA_kernel<<<blocksPerGrid, threadsPerBlock>>>(d_cudaA_distance, d_cudaA_distanceT, n, k);

  cudaMemcpy(cudaA_distance, d_cudaA_distance, n*n*sizeof(float), cudaMemcpyDeviceToHost);
}

void cudaB(float *adjacency, float *adjacencyT, float *cudaB_distance, int n, float p, int w)
{
  float *d_cudaB_distance;
  float *d_cudaB_distanceT;  

  cudaMalloc(&d_cudaB_distance, n*n*sizeof(float));
  cudaMalloc(&d_cudaB_distanceT, n*n*sizeof(float));

  cudaMemcpy(d_cudaB_distance, adjacency, n*n*sizeof(float), cudaMemcpyHostToDevice);
  cudaMemcpy(d_cudaB_distanceT, adjacencyT, n*n*sizeof(float), cudaMemcpyHostToDevice);
  
  dim3 threadsPerBlock; 
  dim3 blocksPerGrid;
  // Max number of threadsPerBlock is 1024 (32*32=1024)
  threadsPerBlock.x = threadsPerBlock.y = 32;
  blocksPerGrid.x = blocksPerGrid.y = n/32;

  int k;
  for (k = 0; k < n; ++k)
  {
    cudaB_kernel<<<blocksPerGrid, threadsPerBlock, 
      threadsPerBlock.x*sizeof(float)>>>(d_cudaB_distance, d_cudaB_distanceT, n, k);
  }

  cudaMemcpy(cudaB_distance, d_cudaB_distance, n*n*sizeof(float), cudaMemcpyDeviceToHost);
}

void cudaC(float *adjacency, float *adjacencyT, float *cudaC_distance, int n, float p, int w)
{
  float *d_cudaC_distance;
  float *d_cudaC_distanceT;  

  cudaMalloc(&d_cudaC_distance, n*n*sizeof(float));
  cudaMalloc(&d_cudaC_distanceT, n*n*sizeof(float));


  int cellsPerThread = 8;

  cudaMemcpy(d_cudaC_distance, adjacency, n*n*sizeof(float), cudaMemcpyHostToDevice);
  cudaMemcpy(d_cudaC_distanceT, adjacencyT, n*n*sizeof(float), cudaMemcpyHostToDevice);

  dim3 threadsPerBlock; 
  dim3 blocksPerGrid;
  // Max number of threadsPerBlock is 1024 (32*32=1024)  
  if (n/cellsPerThread < 32)
  {
    threadsPerBlock.x = threadsPerBlock.y = n/cellsPerThread;
    blocksPerGrid.x = 1;
  }
  else
  {
    threadsPerBlock.x = threadsPerBlock.y = 32;
    blocksPerGrid.x = blocksPerGrid.y = n/(32*cellsPerThread);
  }

  int k;
  for (k = 0; k < n; ++k)
  {
    cudaC_kernel<<<blocksPerGrid, threadsPerBlock, 
      (threadsPerBlock.x+threadsPerBlock.y)*cellsPerThread*sizeof(float)
        >>>(d_cudaC_distance, d_cudaC_distanceT, n, k, cellsPerThread);
  }

  cudaMemcpy(cudaC_distance, d_cudaC_distance, n*n*sizeof(float), cudaMemcpyDeviceToHost);
}

__global__ void cudaA_kernel(float *d_cudaA_distance, float *d_cudaA_distanceT, int n, int k)
{
  int x = blockIdx.x*blockDim.x + threadIdx.x;
  int y = blockIdx.y*blockDim.y + threadIdx.y;

  if (x*n+y < n*n && x+y*n < n*n)  
    if (d_cudaA_distance[x*n+y] > d_cudaA_distanceT[k*n+x] + d_cudaA_distance[k*n+y])
    {
      d_cudaA_distance[x*n+y] = d_cudaA_distanceT[y*n+x] = d_cudaA_distanceT[k*n+x] + d_cudaA_distance[k*n+y];
    }
}


__global__ void cudaB_kernel(float *d_cudaB_distance, float *d_cudaB_distanceT, int n, int k)
{
  extern __shared__ float temp[];

  int x = blockIdx.x*blockDim.x + threadIdx.x;
  int y = blockIdx.y*blockDim.y + threadIdx.y;
  temp[threadIdx.x] = d_cudaB_distanceT[k*n + x];

  if (x*n+y < n*n)  
      if (d_cudaB_distance[x*n+y] > temp[threadIdx.x] + d_cudaB_distance[k*n+y])
        d_cudaB_distance[x*n+y] = d_cudaB_distanceT[y*n+x] = temp[threadIdx.x] + d_cudaB_distance[k*n+y];
}


__global__ void cudaC_kernel(float *d_cudaC_distance, float *d_cudaC_distanceT, int n, int k, int cellsPerThread)
{
  extern __shared__ float temp[];
  float *temp2 = &temp[blockDim.x*cellsPerThread];

  int x = blockIdx.x*blockDim.x + threadIdx.x;
  int y = blockIdx.y*blockDim.x + threadIdx.y;  

  int i;  
  for (i=0; i<cellsPerThread; i++) 
  {
    temp[threadIdx.x*cellsPerThread + i] = d_cudaC_distanceT[k*n + (i+x*cellsPerThread)];
    temp2[threadIdx.y*cellsPerThread + i] = d_cudaC_distance[k*n + i + y*cellsPerThread];
  }

  __syncthreads();
  
  int j;  
  for (i=0; i<cellsPerThread; i++) 
    for (j=0; j<cellsPerThread; j++)
      if ( d_cudaC_distance[(i+x*cellsPerThread)*n + j + y*cellsPerThread] > 
        temp[threadIdx.x*cellsPerThread + i] + temp2[threadIdx.y*cellsPerThread + j] )
      {
        d_cudaC_distance[(i+x*cellsPerThread)*n + j + y*cellsPerThread] = 
        d_cudaC_distanceT[(j + y*cellsPerThread)*n + (i+x*cellsPerThread)] = 
        temp[threadIdx.x*cellsPerThread + i] + temp2[threadIdx.y*cellsPerThread + j];
      }
}


int compare(float *arrayA, float *arrayB, int n)
{
  for (int i = 0; i < n*n; ++i)
  {
    if (arrayB[i] != arrayA[i])
      return 0;    
  }
  return 1;
}

void printMatrix(float *array, int n)
{
  for (int i = 0; i < n; ++i)
  {
    for (int j = 0; j < n; ++j)
    {
      printf("%g ", array[i*n+j]);
    }
    printf("\n");
  }
  printf("\n\n");
}
