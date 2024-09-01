void main() {
  List<int> favNumbers = [4, 8, 15, 16, 23, 42];
//                      0, 1, 2,  3,  4,  5

  favNumbers.length;
  favNumbers[1];
  favNumbers[2] = 5;
  favNumbers.add(5);
  favNumbers.indexOf(8);
  favNumbers.contains(8);
  favNumbers.remove(42);

  print(favNumbers);
}
