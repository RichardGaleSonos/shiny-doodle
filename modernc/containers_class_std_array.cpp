#include <iostream> // ADDED:REG
#include <array> // ADDED:REG

class Foo {};

int main() {
	std::array<Foo, 3> arr;
	const int arrSize = arr.size();

	std::cout << "The array has " << arrSize << " elements\n";

	return 0;
}
