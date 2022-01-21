#include <iostream> // ADDED:REG

class Base
{
	public:
		void sayHi() // build error! forgot to make "sayHi" virtual
		{
			std::cout << "Base says hi\n";
		}
};

class Derived : public Base
{
	public:
		virtual void sayHi()
		{
			std::cout << "Derived says hi\n";
		}
};

void sayHi(Base& b)
{
	b.sayHi();
}

int main()
{
	Derived d;
	sayHi(d);
}

// Output: none -- doesn't compile
