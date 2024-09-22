class Point {
  final int x;
  final int y;

  // const constructor must be used with const object creation
  const Point(this.x, this.y);

  @override
  String toString() {
    return 'Point{x: $x, y: $y}';
  }
}

void main() {
  const point = Point(3, 4);
  // point.x = 5;
  print(point);
}
