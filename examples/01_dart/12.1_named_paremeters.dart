/*
Wrapping parameters in a curly brace, you can define parameters 
that have names
*/

int sum({required int a, required int b}) => a + b;

void printName(String firstName, String lastName, {String? middleName}) {
  print('$firstName ${middleName ?? ''} $lastName');
}

// If the type of a named parameter is non-nullable, then you must 
// either provide a default value or mark the parameter as required 
/*
void printName(String firstName, String lastName, {String middleName = ''}) {
  print('$firstName $middleName $lastName');
}
*/


void main() {
  print(sum(a: 10, b: 20));

  printName('Ali', 'Faleh');
  printName('Ali', 'Faleh', middleName: 'Saleh');
  // Named arguments can be placed anywhere in the argument list
  printName('Ali', middleName: 'Saleh', 'Faleh');
}