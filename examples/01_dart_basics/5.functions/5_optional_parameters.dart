/*
With Dart, you can make pamaters optional by wrapping them in brackets
*/

int sumUpToFive(int a, {required int b, int? c, int? d, int? e}) {
  int sum = a + b;
  if (c != null) sum += c;
  if (d != null) sum += d;
  if (e != null) sum += e;
  return sum;
}

void main(List<String> args) {
  // Error: The argument for the named parameter 'b' was not provided.
  //print(sumUpToFive(1)); 
  print(sumUpToFive(1, b: 2));
  print(sumUpToFive(1, c: 2, b:3));
  print(sumUpToFive(1, b:2, c:3, d:4));
  print(sumUpToFive(1, b:2, c:3, d:4, e:5));
}