#include <stdio.h> // ADDED:REG

#define SIZE 10

int main()
{
	int v[SIZE];
	const int arrSize = sizeof(v) / sizeof(v[0]);

	printf("The array has %d elements\n", arrSize);

	return 0;
}
