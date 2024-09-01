import 'dart:io';

void main() {
  print("Enter your first number:");
  int num1 = int.parse(stdin.readLineSync()!);
  print("Enter your first number:");
  int num2 = int.parse(stdin.readLineSync()!);
  print(num1 + num2);
}
