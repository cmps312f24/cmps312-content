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

/*
Use object pattern to simultaneously match the object to its type 
  and deconstruct it (i.e. extract values from it) in a single 
  operation.
Allows for easier type-specific handling + at the same time
  exact values for the object
*/
double calculateArea(Shape shape) => switch (shape) {
      // Use the object pattern to match the object to its type and 
      // then against the class properties to extract values from 
      // the object in the same expression using the : operator
      Rectangle(width: var w, length: var l) => w * l,
      Circle(radius: var r) => math.pi * r * r,
      _ => throw UnimplementedError(),
    };

void main() {
  var circle = Circle(5);
  var rectangle = Rectangle(4, 6);

  // The object pattern is used to extract values from the object 
  // using the : operator
  var Rectangle(:width, length:length) = rectangle;
  print('Width: $width, Height: $length'); 

  var Circle(radius:r) = circle;
  print('Radius: $r');

  var area = calculateArea(circle);
  print('Area of the circle: $area');
  area = calculateArea(rectangle);
  print('Area of the rectangle: $area');
}
