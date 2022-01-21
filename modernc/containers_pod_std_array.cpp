#include <array> // ADDED:REG
#include <cstdio> // ADDED:REG

#define SIZE 10

int main()
{
	std::array<int, SIZE> w;

	const int arrSize = w.size();

	printf("The array has %d elements\n", arrSize);

	return 0;
}
