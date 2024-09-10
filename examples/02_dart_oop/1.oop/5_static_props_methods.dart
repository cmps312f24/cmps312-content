class Car {
  // Static property to keep track of the number of cars created
  static int carCount = 0;

  // Instance property
  String model;

  // Constructor
  Car(this.model) {
    carCount++; // Increment car count whenever a new car is created
  }

  // Static method to get the total number of cars
  static int getCarsCount() {
    return carCount;
  }
}

void main() {
  // Creating instances of Car
  Car car1 = Car('Toyota');
  Car car2 = Car('Honda');

  print(car1.model); // Toyota
  print(car2.model); // Honda
  print(Car.getCarsCount()); // 2

  // Accessing the static property through the class
  print('Total cars: ${Car.getCarsCount()}');
}
