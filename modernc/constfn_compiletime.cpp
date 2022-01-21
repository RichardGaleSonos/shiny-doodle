constexpr int factorial(int n)
{
	return n <= 1 ? 1 : (n * factorial(n - 1));
}

int someValue = factorial(10);

int main()
{
	return 0;
}