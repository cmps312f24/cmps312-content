import 'dart:math' as math;

abstract class Shape {}

class Circle extends Shape {
  final double radius;
  Circle(this.radius);
}

class Rectangle extends Shape {
  final double width;
  final double height;
  Rectangle(this.width, this.height);
}

double calculateArea(Shape shape) => switch (shape) {
      Rectangle(width: var l, height: var h) => l * h,
      Circle(radius: var r) => math.pi * r * r,
      _ => throw UnimplementedError(),
    };

double getArea(Shape shape) {
  // Using pattern matching to calculate area based on shape type
  /*
    This if pattern allows you to check the structure of the data 
    and extract relevant values in the same expression.

    if (shape is Circle(:var radius)) checks if the shape is a Circle 
      and extracts the radius field.
    if (shape is Rectangle(:var width, :var height)) checks if the shape 
      is a Rectangle and extracts width and height.
  */
  if (shape case Circle(:var radius)) {
    return math.pi * radius * radius;
  } else if (shape case Rectangle(:var width, :var height)) {
    return width * height;
  } else {
    throw Exception('Unknown shape');
  }
}

void main() {
  var circle = Circle(5);
  var rectangle = Rectangle(4, 6);

  var area = getArea(circle);
  print('Area of the circle: $area'); // Outputs: Area of the circle: 78.5
  area = getArea(rectangle);
  print('Area of the rectangle: $area'); // Outputs: Area of the rectangle: 24

  area = calculateArea(circle);
  print('Area of the circle: $area'); // Outputs: Area of the circle: 78.5
  area = calculateArea(rectangle);
  print('Area of the rectangle: $area'); // Outputs: Area of the rectangle: 24
}
