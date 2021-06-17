#include "mytour.h"

void my_tour(const point cities[], int tour[], int ncities)
{
	void simple_find_tour(const point cities[], int tour[], int ncities)
	{
		int i, j;
		char *visited = alloca(ncities);
		int ThisPt, ClosePt = 0;
		float CloseDist;
		int endtour = 0;



		for (i = 0; i < ncities; i++)
			visited[i] = 0;
		ThisPt = ncities - 1;
		visited[ncities - 1] = 1;
		tour[endtour++] = ncities - 1;

		//changes made here

		float tempv1;
		for (i = 1; i < ncities; i++) {
			int visitedN = sizeof(float) * ncities + sizeof(float)*(ncities % 4);
			float visited[visitedN];
			__m128 nulls = _mm_set1_ps(0);
			#pragma omp for 
			for (i = 0; i < visitedN; i += 4) {
				_mm_store_ps(&visited[i], nulls);
			}

			CloseDist = DBL_MAX;
			for (j = 0; j < ncities - 1; j++) {
				if (!visited[j]) {
					tempv1 = dist(cities, ThisPt, j);
					if (tempv1 < CloseDist) {
						CloseDist = tempv1;
						ClosePt = j;
					}
				}
			}
			tour[endtour++] = ClosePt;
			visited[ClosePt] = 1;
			ThisPt = ClosePt;
		}
	}
}
