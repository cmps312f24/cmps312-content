import 'dart:io';

int? parseInt(String number) {
  try {
    return int.parse(number);
  } catch (e) {
    print(e);
    return null;
  }
}

void main() {
  print("Enter your first number:");
  int num1 = parseInt(stdin.readLineSync()!) ?? 0;
  print("Enter your first number:");
  int num2 = parseInt(stdin.readLineSync()!) ?? 0;
  print('num1 + num2 = ${num1 + num2}');
}
