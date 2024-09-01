void main() {
  List<int> numbers = [1, 2, 3, 4, 5];
  numbers.forEach((num) {
    print(num);
  });

  // or
  numbers.forEach((num) => print(num));

  // or
  numbers.forEach(print);

  // print only even numbers
  numbers.forEach((num) {
    if (num % 2 == 0) {
      print(num);
    }
  });

  // or
  numbers.where((num) => num % 2 == 0).forEach(print);

  // or
  numbers.where((num) => num.isEven).forEach(print);
  
}
