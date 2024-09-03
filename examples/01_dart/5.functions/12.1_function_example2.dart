import 'dart:math' as math;

// Function with a block body
int max(int a, int b) {
  return a > b ? a : b;
}

// Function with a block body and named parameters
int max2({required int a, required int b}) {
  return a > b ? a : b;
}

// Function with an expression body
int max3(int a, int b) => a > b ? a : b;
// Function assigned to a variable
final max4 = (int a, int b) => a > b ? a : b;

// Function with a block body and optional parameter
int sum({required int a, int b = 0}) {
  return a + b;
}

// Function with expression body (Lambda Expression)
// Omit return type if using `var` or `final` (Dart infers the type)
int sum2({required int a, int b = 0}) => a + b;

// Arrow function - Lambda expression
// Omit return type if using `var` or `final` for type inference
final sum3 = ({required int a, int b = 0}) => a + b;

void display(dynamic value) => print(value);

void main() {
  // Calling the function with positional arguments
  print(max(1, 2)); // Prints: 2
  // Calling the function with named arguments
  print(max2(a: 1, b: 2)); // Prints: 2
  print(max3(1, 2)); // Prints: 2
  print(max4(1, 2)); // Prints: 2

  print(sum(a: 2, b: 3)); // Prints: 5

  display(10);
  display('Hello, Dart!');
  display(math.pi);
}
