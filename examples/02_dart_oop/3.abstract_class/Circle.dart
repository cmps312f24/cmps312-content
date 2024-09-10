import 'dart:math';
import 'Shape.dart';

class Circle extends Shape {
  final double radius;

  Circle(this.radius);

  @override
  double area() => pi * pow(radius, 2);

  @override
  String get name => 'Circle';
}