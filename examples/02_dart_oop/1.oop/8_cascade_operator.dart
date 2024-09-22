/*
  cascade operator (..) in allows you to perform a series of 
  operations on the same object without having to repeat 
  the object reference for each operation 
*/

class Person {
  String name = '';
  int age = 0;

  void setName(String name) {
    this.name = name;
  }

  void setAge(int age) {
    this.age = age;
  }

  void greet() {
    print("Hello, my name is $name and I am $age years old.");
  }
}

void main() {
  // Without cascade operator:
  var person1 = Person();
  person1.setName("Ali");
  person1.setAge(30);
  person1.greet();
  
  // With cascade operator:
  var person2 = Person()
    ..setName("Fatima")
    ..setAge(25)
    ..greet();
}
