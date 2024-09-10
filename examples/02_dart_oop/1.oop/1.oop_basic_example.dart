class Person {
  // Use final for properties that are initialized once
  // and won't change
  final String firstName;
  final String lastName;
  final int age;
  
  // Constructor with initializer list
  // In Dart, the colon (:) in a constructor is used to initialize 
  // instance variables before the constructor body runs. 
  // This is known as an initializer list.
  /*Person(String firstName, String lastName, int age) 
      : firstName = firstName,
        lastName = lastName,
        age = age {
          // Initialization code goes here
        }*/

  // Constructor with named parameters
  // Use required for non-nullable properties to ensure that
  // a value is provided during object creation
  /*** Better way to write the above constructor ***/
  Person({required this.firstName, required this.lastName, required this.age});

  // Computed property (getter)
  String get fullName => '$firstName $lastName';

  // Method to check if the person is a minor
  bool isMinor() => age < 18;
}

void main() {
  final person = Person(firstName: 'John', lastName: 'Doe', age: 17);
  print('Full name: ${person.fullName}');
  print('Is minor: ${person.isMinor()}');
}
