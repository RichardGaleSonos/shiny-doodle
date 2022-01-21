#include <memory> // ADDED:REG

class Foo
{
	// ADDED:REG
};

void someFunction(Foo* foo) 
{
	delete foo;
}

int main()
{
	auto foo = std::make_unique<Foo>();

	// pass ownership of foo to someFunction
	someFunction(std::move(foo));

	// "foo" is now set to nullptr
	Foo bug = *foo;

	return 0;
}
