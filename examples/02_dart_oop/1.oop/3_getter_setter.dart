void main() {
  // Write a simple class with a getter and a setter
  var person = Person(16);
  print('person.age = ${person.age}');
  person.age = 17;
  print('person.age = ${person.age}');
}

class Person {
  late int _age;

  Person(int age) {
    this.age = age;
  }

  int get age => _age;

  set age(int value) {
    if (value >= 0) {
      _age = value;
    } else {
      throw Exception('Age can\'t be negative');
    }
  }
}
