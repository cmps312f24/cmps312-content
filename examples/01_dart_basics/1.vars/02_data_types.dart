void main() {
  String name = "Ali";
  int age = 19;
  double gpa = 3.5;
  bool isQUStudent = true;

  print('name: $name \nage: $age \ngpa: $gpa \nisQUStudent: $isQUStudent');

  print(
      'name: ${name.runtimeType} \nage: ${age.runtimeType} \ngpa: ${gpa.runtimeType} \nisQUStudent: ${isQUStudent.runtimeType}');

  // Late modifier is used to declare a variable
  // without initializing it immediately and the
  // variable is initialized at a later time
  late int exampleInt;
  exampleInt = 1;
  print(exampleInt);

  dynamic dynamicVar = 4.5;
  dynamicVar = "text"; // can assign another datatype
  print(dynamicVar);
}
