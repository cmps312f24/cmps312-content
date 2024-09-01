void main() {
  final Car blueCar = Car(color: "blue", engine: "v8");
  print(blueCar.color);
}

class Car {
  //! attribute
  final String color;
  final String engine;

  //! constructor
  Car({required this.color, required this.engine});

  //! methods
  void drive() {
    print("car is moving");
  }

  void whichColor() {
    print('car color: ${this.color}');
  }
}
