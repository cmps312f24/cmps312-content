import 'Shape.dart';

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