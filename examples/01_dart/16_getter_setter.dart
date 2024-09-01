void main() {
 // Write a simple class with a getter and a setter
  var person = Person();
  person.age = 20;
  print('person.age = ${person.age}');
}

class Person {
  int _age = 0;

  int get age => _age;

  set age(int value) {
    if (value >= 0) {
      _age = value;
    }
  }
}
