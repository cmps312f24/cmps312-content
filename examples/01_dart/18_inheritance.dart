void main() {
  // Create an inheritance vehicle and car example. Include mixin
  // Create a class called Vehicle. A vehicle has a make (String) and a model (String).
  // Create a class called Car that inherits from Vehicle. A car has a color (String) and a year (int).
  // Create a mixin called Drive. Drive has a method called drive. When called, it should print "vehicle is moving".
  // Create a mixin called Park. Park has a method called park. When called, it should print "vehicle is parked".
  // Create a Car object and call the drive and park methods.

  Car myCar = Car(color: "red", year: 2021, make: "Toyota", model: "Corolla");
  print('myCar.color: ${myCar.color}');
  myCar.drive();
  myCar.park();
}

class Vehicle with Drive, Park {
  String make;
  String model;

  Vehicle({required this.make, required this.model});
}

class Car extends Vehicle {
  String color;
  int year;

  Car({required this.color, required this.year, required String make, required String model}) : super(make: make, model: model);
}

// Mixins are a way of reusing code in multiple class hierarchies.
mixin Drive {
  void drive() {
    print("vehicle is moving");
  }
}

mixin Park {
  void park() {
    print("vehicle is parked");
  }
}