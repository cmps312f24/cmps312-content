/*int max(int a, int b) {
  return a > b ? a : b;
} */

int max(int a, int b) => a > b ? a : b;

// Positional parameters
// Named parameters
int add( int a, [int? b, int? c]) => a + (b ?? 0) + (c ?? 0);

void main(List<String> args) {
  var result = add(30, 20);
  print(result);
  print(add(10, 10, 30));

  print(max(10, 20));
  print(max(12, 4));
  print(max(10, 10));
}