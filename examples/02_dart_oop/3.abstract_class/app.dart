import 'Circle.dart';
import 'Rectangle.dart';

void main() {

  

  var shapes = [
    Circle(5),
    Rectangle(4, 6),
    Circle(3),
    Rectangle(5, 5),
  ];

  for (var shape in shapes) {
    print('Area of ${shape.name}: ${shape.area()}');
  }
}