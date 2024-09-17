// Extension method extending String class
extension StringExtensions on String {
  int parseInt() {
    return int.parse(this);
  }

   String lastChar2() {
    return this.substring(this.length - 1);
  }

  // You can omit the 'this' keyword
  String lastChar() {
    return substring(length - 1);
  }
}

// Extension method extending int class
extension IntExtensions on int {
  bool get isEven => this % 2 == 0;
  int add(int b) => this + b;
}

void main() {
  var name = "Fatima";
  print('Last char: ${name.lastChar()}');

  var number = "123".parseInt();
  print("Parsed number: $number");

  var num = 10;
  print("Is $num even: ${num.isEven}");
}
