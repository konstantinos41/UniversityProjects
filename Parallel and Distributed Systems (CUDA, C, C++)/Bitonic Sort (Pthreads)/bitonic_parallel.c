/*
  bitonic_mavrkons.c

  The following implementations of sorting are included in this file:
    - Qsort
    - Imperative Sort
    - Recursive Sort
    - Pthreads Bitonic sort with some Qsort
    - OpenMP Imperative sort


  Author: <Konstantinos Mavrodis>
  Contact: <kmavrodis@outlook.com>
*/


#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

#include <pthread.h>
#include <omp.h>


const int ASCENDING  = 1;
const int DESCENDING = 0;

int availableThreads;
pthread_mutex_t mutexThreads;


struct threadData
{
  int *elements, cnt, lo, dir;
};


void initElements(int *, int *, int);
void reinitElements(int *, int *, int);
void printElements(int *, int);
inline void exchange(int *, int, int);
void test(int *, int);
inline void compare(int *, int, int, int);
inline int qsort_compareAscending (const void *, const void *);
inline int qsort_compareDescending (const void *, const void *);


void impBitonicSort(int *, int);

void sort(int *, int);
void recBitonicSort(int *, int, int, int);
void bitonicMerge(int *, int, int, int);

void sort_pthreads(int *, int);
void *recBitonicSort_pthreads(void *);
void *bitonicMerge_pthreads(void *);

void impBitonicSort_openMP(int *, int, int);


int main(int argc, char *argv[])
{
  if (argc != 3)
  {
    printf("Invalid number of arguments. You should provide 2 of them.");
    exit(0);
  }

  // Helper variables for keeping track of time
  struct timeval startwtime, endwtime;
  double seq_time;

  // Number of random elements (2^argv[1])
  int q = 1<<atoi(argv[1]);
  // Number of threads (2^argv[2])
  int p = 1<<atoi(argv[2]);

  // Array of the elements that will be sorted
  int *elements = (int *) malloc(q * sizeof(int));
  int *backupElements = (int *) malloc(q * sizeof(int));

  availableThreads = p - 1;
  pthread_mutex_init(&mutexThreads, NULL);

  initElements(elements, backupElements, q);

  // Qsort
  gettimeofday (&startwtime, NULL);
  impBitonicSort(elements, q);
  gettimeofday (&endwtime, NULL);
  seq_time = (double)((endwtime.tv_usec - startwtime.tv_usec)/1.0e6
          + endwtime.tv_sec - startwtime.tv_sec);

  printf("Qsort wall clock time              = \x1B[34m %f ", seq_time);
  test(elements, q);

  // Imperative Sort
  reinitElements(elements, backupElements, q);
  gettimeofday (&startwtime, NULL);
  impBitonicSort(elements, q);
  gettimeofday (&endwtime, NULL);
  seq_time = (double)((endwtime.tv_usec - startwtime.tv_usec)/1.0e6
          + endwtime.tv_sec - startwtime.tv_sec);

  printf("Imperative wall clock time         = \x1B[34m %f ", seq_time);
  test(elements, q);

  // Recursive Sort
  reinitElements(elements, backupElements, q);

  gettimeofday (&startwtime, NULL);
  sort(elements, q);
  gettimeofday (&endwtime, NULL);
  seq_time = (double)((endwtime.tv_usec - startwtime.tv_usec)/1.0e6
              + endwtime.tv_sec - startwtime.tv_sec);

  printf("Recursive wall clock time          = \x1B[34m %f ", seq_time);
  test(elements, q);


  // Pthreads Recursive Sort
  reinitElements(elements, backupElements, q);
  gettimeofday (&startwtime, NULL);
  sort_pthreads(elements, q);
  gettimeofday (&endwtime, NULL);
  seq_time = (double)((endwtime.tv_usec - startwtime.tv_usec)/1.0e6
          + endwtime.tv_sec - startwtime.tv_sec);

  printf("Pthreads recursive wall clock time = \x1B[34m %f ", seq_time);
  test(elements, q);

  // OpenMp Imperative Sort
  reinitElements(elements, backupElements, q);
  gettimeofday (&startwtime, NULL);
  impBitonicSort_openMP(elements, q, p);
  gettimeofday (&endwtime, NULL);
  seq_time = (double)((endwtime.tv_usec - startwtime.tv_usec)/1.0e6
          + endwtime.tv_sec - startwtime.tv_sec);

  printf("OpenMP Imperative wall clock time  = \x1B[34m %f ", seq_time);
  test(elements, q);
}


/////////////////////// Helper Functions ////////////////////////////

/** procedure initElements() : initialize array "elements" with data **/
void initElements(int *elements, int *backupElements, int q)
{
  int i;
  for (i = 0; i < q; i++)
  {
    elements[i] = backupElements[i] = rand() % q;
  }
}

void reinitElements(int *elements, int *backupElements, int q)
{
  int i;
  for (i = 0; i < q; i++)
  {
    elements[i] = backupElements[i];
  }
}

/** procedure  printElements() : print array elements **/
void printElements(int *elements, int q)
{
  int i;
  for (i = 0; i < q; i++)
  {
    printf("%d\n", elements[i]);
  }
  printf("\n");
}

/** INLINE procedure exchange() : pair swap **/
inline void exchange(int elements[], int i, int j)
{
  int t;
  t = elements[i];
  elements[i] = elements[j];
  elements[j] = t;
}

/** procedure compare()
   The parameter dir indicates the sorting direction, ASCENDING
   or DESCENDING; if (a[i] > a[j]) agrees with the direction,
   then a[i] and a[j] are interchanged.
**/
inline void compare(int elements[], int i, int j, int dir)
{
  if (dir==(elements[i] > elements[j]))
    exchange(elements, i, j);
}

inline int qsort_compareAscending(const void * a, const void * b)
{
  return ( *(int*)a - *(int*)b );
}

inline int qsort_compareDescending(const void * a, const void * b)
{
  return ( *(int*)b - *(int*)a );
}


/** procedure test() : verify sort results **/
void test(int elements[], int q)
{
  int pass = 1;
  int i;
  for (i = 1; i < q; i++)
    pass &= (elements[i-1] <= elements[i]);
  printf("%s\n",(pass) ? "\x1B[32m""PASS" : "\x1B[31m""FAIL");
  printf("\x1B[0m");
}



///////////////////////// Imperative Sort ///////////////////////////////

void impBitonicSort(int *elements, int q)
{
  int i, j, k;
  for (k=2; k<=q; k=2*k)
  {
    for (j=k>>1; j>0; j=j>>1)
    {
      for (i=0; i<q; i++)
      {
          int ij = i^j;
          if ((ij) > i)
        {
            if ((i&k) == 0 && elements[i] > elements[ij])
            exchange(elements, i, ij);
            if ((i&k) != 0 && elements[i] < elements[ij])
            exchange(elements, i, ij);
          }
      }
    }
  }
}

///////////////////////// Recursive Sort ////////////////////////////////

/** function sort()
   Caller of recBitonicSort for sorting the entire array of length N
   in ASCENDING order
 **/
void sort(int elements[], int q)
{
  recBitonicSort(elements, 0, q, ASCENDING);
}

/** function recBitonicSort()
    first produces a bitonic sequence by recursively sorting
    its two halves in opposite sorting orders, and then
    calls bitonicMerge to make them in the same order
 **/
void recBitonicSort(int elements[], int lo, int cnt, int dir)
{
  if (cnt>1)
  {
    int k=cnt/2;
    recBitonicSort(elements, lo, k, ASCENDING);
    recBitonicSort(elements, lo+k, k, DESCENDING);
    bitonicMerge(elements, lo, cnt, dir);
  }
}

/** Procedure bitonicMerge()
   It recursively sorts a bitonic sequence in ascending order,
   if dir = ASCENDING, and in descending order otherwise.
   The sequence to be sorted starts at index position lo,
   the parameter cbt is the number of elements to be sorted.
 **/
void bitonicMerge(int elements[], int lo, int cnt, int dir)
{
  if (cnt>1)
  {
    int k=cnt/2;
    int i;
    for (i=lo; i<lo+k; i++)
      compare(elements, i, i+k, dir);
    bitonicMerge(elements, lo, k, dir);
    bitonicMerge(elements, lo+k, k, dir);
  }
}


/////////////////////// Pthreads Recursive Sort ////////////////////////////

void sort_pthreads(int elements[], int q)
{
  struct threadData myStruct;
  myStruct.elements = elements;
  myStruct.cnt = q;
  myStruct.lo = 0;
  myStruct.dir = ASCENDING;

  recBitonicSort_pthreads(&myStruct);
}

void *recBitonicSort_pthreads(void *threadarg)
{
  struct threadData *argumentStruct;
  argumentStruct = (struct threadData *) threadarg;

  struct threadData firstStruct;
  firstStruct.elements = argumentStruct->elements;
  firstStruct.cnt = argumentStruct->cnt / 2;
  firstStruct.lo = argumentStruct->lo;
  firstStruct.dir = ASCENDING;

  struct threadData secondStruct;
  secondStruct.elements = argumentStruct->elements;
  secondStruct.cnt = argumentStruct->cnt / 2;
  secondStruct.lo = argumentStruct->lo + argumentStruct->cnt / 2;
  secondStruct.dir = DESCENDING;

  if (argumentStruct->cnt > 1)
  {
    if (availableThreads > 0)
    {
      pthread_t thread;

      pthread_mutex_lock(&mutexThreads);
      availableThreads--;
      pthread_mutex_unlock(&mutexThreads);

      int rc = pthread_create(&thread, NULL, recBitonicSort_pthreads, &firstStruct);
      if (rc)
      {
        printf("ERROR; return code from pthread_create() is %d\n", rc);
        exit(-1);
      }

      recBitonicSort_pthreads(&secondStruct);

      pthread_join(thread, NULL);

      /* I commented out the following because while using it, I was getting
        more excecution time. */
      // pthread_mutex_lock(&mutexThreads);
      // availableThreads++;
      // pthread_mutex_unlock(&mutexThreads);

      bitonicMerge_pthreads(argumentStruct);
    }
    else
    {
      if (argumentStruct->dir == ASCENDING)
        qsort(&argumentStruct->elements[argumentStruct->lo],
          argumentStruct->cnt, sizeof(int), qsort_compareAscending);
      else
        qsort(&argumentStruct->elements[argumentStruct->lo],
          argumentStruct->cnt, sizeof(int), qsort_compareDescending);
    }
  }
}

void *bitonicMerge_pthreads(void *threadarg)
{
  struct threadData *argumentStruct;
  argumentStruct = (struct threadData *) threadarg;

  if (argumentStruct->cnt > 1)
  {
    int k = argumentStruct->cnt / 2;
    int i;
    for (i = argumentStruct->lo; i < argumentStruct->lo + k; i++)
      compare(argumentStruct->elements, i, i+k, argumentStruct->dir);

    struct threadData firstStruct;
    firstStruct.elements = argumentStruct->elements;
    firstStruct.cnt = k;
    firstStruct.lo = argumentStruct->lo;
    firstStruct.dir = argumentStruct->dir;

    struct threadData secondStruct;
    secondStruct.elements = argumentStruct->elements;
    secondStruct.cnt = k;
    secondStruct.lo = argumentStruct->lo + k;
    secondStruct.dir = argumentStruct->dir;

    if (availableThreads > 0)
    {
      pthread_t thread;

      pthread_mutex_lock(&mutexThreads);
      availableThreads--;
      pthread_mutex_unlock(&mutexThreads);

      int rc = pthread_create(&thread, NULL, bitonicMerge_pthreads, &firstStruct);
      if (rc)
      {
        printf("ERROR; return code from pthread_create() is %d\n", rc);
        exit(-1);
      }

      bitonicMerge_pthreads(&secondStruct);

      pthread_join(thread, NULL);

      /* I commented out the following because when using it I was getting
        more excecution time. */
      // pthread_mutex_lock(&mutexThreads);
      // availableThreads++;
      // pthread_mutex_unlock(&mutexThreads);
    }
    else
    {
      bitonicMerge_pthreads(&firstStruct);
      bitonicMerge_pthreads(&secondStruct);
    }
  }
}


//////////////////////////// OpenMP Imperative //////////////////////////////
void impBitonicSort_openMP(int *elements, int q, int p)
{
  int i, j, k;
  for (k=2; k<=q; k=2*k)
  {
    for (j=k>>1; j>0; j=j>>1)
    {
      #pragma omp parallel for schedule(dynamic, q/p)
      for (i=0; i<q; i++)
      {
        int ij = i^j;
        if ((ij) > i)
        {
          if ((i&k) == 0 && elements[i] > elements[ij])
            exchange(elements, i, ij);
          if ((i&k) != 0 && elements[i] < elements[ij])
            exchange(elements, i, ij);
        }
      }
    }
  }
}
