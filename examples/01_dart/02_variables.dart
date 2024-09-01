import 'dart:io';

void main() {
  int intVar = 2; // initialization
  print('Int var: $intVar.');

  late int studentsCount; // declaration
  // Write code to prompt user for input

  print('Enter the students count: ');
  var input = stdin.readLineSync();
  studentsCount = int.parse(input!); // allocation
  print('Students Count: $studentsCount');

/**** Type Inference ***
You can declare variables without explicitly specifying their 
type using var. 
Thanks to type inference, these variables' types are determined 
by their initial values
*/
  var name = 'Voyager I';
  var year = 1977;
  var antennaDiameter = 3.7;
  var flybyObjects = ['Jupiter', 'Saturn', 'Uranus', 'Neptune'];
  var image = {
    'tags': ['saturn'],
    'url': '//path/to/saturn.jpg'
  };

  print(
      'Name: $name \nYear: $year \nAntenna Diameter: $antennaDiameter \nFlyby Objects: $flybyObjects \nImage: $image');

  var test;
  print(test.runtimeType);
  print(test);
  print(test + " will fail"); // will fail
}
