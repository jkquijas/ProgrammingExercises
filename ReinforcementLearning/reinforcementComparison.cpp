#include <iostream>
#include <armadillo>

using namespace arma;
using namespace std;

int main(int argc, char const *argv[]) {
  
  mat A;
  A << -1 << 2 << endr << 3 << 5;
  std::cout << A << std::endl;

  fmat B;
  B.randu(4, 5);
  std::cout << B << std::endl;
  return 0;

}
