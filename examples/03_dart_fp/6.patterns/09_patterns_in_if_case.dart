/*
You can use patterns inside an if –case statement for more complex 
matching logic, making conditional checks easier and more expressive
*/
import 'dart:math' as math;

abstract class Shape {}

class Circle extends Shape {
  final double radius;
  Circle(this.radius);
}

class Rectangle extends Shape {
  final double width;
  final double length;
  Rectangle(this.width, this.length);
}

double calculateArea(Shape shape) {
  // Using pattern matching to calculate area based on shape type
  /*
    In if-case statement object pattern can be used to match 
    the object to its type and extract relevant values in the
    same expression using the : operator

    if (shape is Circle(:var radius)) checks if the shape is a Circle 
      and extracts the radius field.
    if (shape is Rectangle(:var width, :var length)) checks if the 
      shape is a Rectangle and extracts width and length.
  */
  if (shape case Circle(:var radius)) {
    return math.pi * radius * radius;
  } else if (shape case Rectangle(:var width, length:var length)) {
    return width * length;
  } else {
    throw Exception('Unknown shape');
  }
}

void main() {
  var circle = Circle(5);
  var rectangle = Rectangle(4, 6);

  var area = calculateArea(circle);
  print('Area of the circle: $area');
  area = calculateArea(rectangle);
  print('Area of the rectangle: $area');
}
