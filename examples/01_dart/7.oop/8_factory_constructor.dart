/*
Dart supports factory constructors, which can return subtypes 
or even null. 
To create a factory constructor, use the factory keyword
*/

class Square extends Shape {}
class Circle extends Shape {}

class Shape {
  Shape();

  factory Shape.fromTypeName(String typeName) {
    if (typeName == 'square') return Square();
    if (typeName == 'circle') return Circle();

    throw ArgumentError('Unrecognized $typeName');
  }
}

void main() {
  var shape = Shape.fromTypeName('square');
  print(shape);
}