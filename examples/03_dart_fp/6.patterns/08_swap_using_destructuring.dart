void main() {
  var (a, b) = ('left', 'right');
  (b, a) = (a, b); // Swap the values of a and b
  print('$a $b'); // Prints "right left"
}