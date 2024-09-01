

void main() {
  String name = "Ali";
  int age = 19;
  double gpa = 3.5;
  bool isQUStudent = true;

  print('name: $name \nage: $age \ngpa: $gpa \nisQUStudent: $isQUStudent');

  bool boolVar = false;
  print(boolVar);
  int intVar = -1;
  print(intVar);
  double doubleVar = 1.5;
  print(doubleVar);

  String stringVar = 'Hello, Dart';
  print(stringVar);
  print('The value is :  $intVar');
  print('The value is :  $boolVar');

  dynamic dynamicVar = 4.5;
  dynamicVar = "text"; // can assign another datatype
  print(dynamicVar);

  // keywords:
  late int exampleInt;
  exampleInt = 1;
  print(exampleInt);

  final int finalInt = 3;
  print(finalInt);

  const int constInt = 4;
  print(constInt);

  var varVar = "text"; 
  //varVar = 1; // cannot assign another datatype
  print(varVar);

}