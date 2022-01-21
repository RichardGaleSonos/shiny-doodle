bool compare(int a, int b) {
	return a > b;
}

int main()
{
	bool (*fp)(int, int) = compare;

	return fp(15, 4);
}