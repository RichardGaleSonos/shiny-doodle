#include <iostream> // ADDED:REG

class Foo {};

int main() {
	Foo arr[3];
	const int arrSize = sizeof(arr) / sizeof(arr[0]);

	std::cout << "The array has " << arrSize << " elements\n";

	return 0;
}
