/*
String interpolation
Allows you to put the value of an expression inside a string, 
use ${expression}. If the expression is an identifier, 
you can omit the {}
*/

void main() {
  String name = "Fatima";
  int age = 18;
  print('''My name is $name and I am $age years old. 
    In two years, I will be ${age + 2}'''); 
}