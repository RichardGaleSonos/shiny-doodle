int main()
{
	auto lambda = [](int a, int b) {
		return a > b;
	};

	return lambda(15, 4);
}