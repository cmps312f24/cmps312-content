import 'dart:math';

abstract class Shape {
  double area();
  String get name => 'Shape';
}

class Rectangle extends Shape {
  final double width;
  final double height;

  Rectangle(this.width, this.height);

  bool get isSquare => width == height;

  @override
  double area() => width * height;

  @override
  String get name => isSquare ? 'Square' : 'Rectangle';
}

class Circle extends Shape {
  final double radius;

  Circle(this.radius);

  @override
  double area() => pi * pow(radius, 2);

  @override
  String get name => 'Circle';
}