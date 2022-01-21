#include <stdio.h> // ADDED:REG

class Foo {};

int main() {
	Foo arr[3];
	const int arrSize = sizeof(arr) / sizeof(arr[0]);

	printf("The array has %d elements\n", arrSize);

	return 0;
}
