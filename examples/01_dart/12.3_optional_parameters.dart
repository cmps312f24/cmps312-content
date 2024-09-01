/*
With Dart, you can make pamaters optional by wrapping them in brackets
*/

int sumUpToFive(int a, [int? b, int? c, int? d, int? e]) {
  int sum = a;
  if (b != null) sum += b;
  if (c != null) sum += c;
  if (d != null) sum += d;
  if (e != null) sum += e;
  return sum;
}

void main(List<String> args) {
  print(sumUpToFive(1));
  print(sumUpToFive(1, 2));
  print(sumUpToFive(1, 2, 3));
  print(sumUpToFive(1, 2, 3, 4));
  print(sumUpToFive(1, 2, 3, 4, 5));
}