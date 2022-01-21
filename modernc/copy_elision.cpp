#include <iostream>

class Noisy {
public:
	Noisy() { std::cout << "constructed at \t\t" << this << '\n'; }
	Noisy(const Noisy&) { std::cout << "copy-constructed at \t\t" << this << '\n'; }
	Noisy(const Noisy&&) { std::cout << "move-constructed at \t\t" << this << '\n'; }
	~Noisy() { std::cout << "destructed at \t\t" << this << '\n'; }
};

Noisy f() {
	Noisy v = Noisy();
	return v;
}

int main() {
	Noisy v = f();
	std::cout << "&v = " << &v << '\n';
	return 0;
}
