// Define an enum class with properties and methods
enum VehicleType {
  car(120), 
  motorcycle(180), 
  bicycle(25);

  // Property to store the max speed
  final int maxSpeed;

  // Constructor to initialize the property
  const VehicleType(this.maxSpeed);

  // Method to display information about the vehicle
  void displayInfo() {
    print('A $name can reach a max speed of $maxSpeed km/h.');
  }
}

void main() {
  // Access enum values and their properties
  VehicleType vehicle = VehicleType.car;

  // Call method on the enum value
  vehicle.displayInfo(); // Output: A car can reach a max speed of 120 km/h.

  // You can access the maxSpeed property directly as well
  print('Max speed of motorcycle: ${VehicleType.motorcycle.maxSpeed} km/h');
}
