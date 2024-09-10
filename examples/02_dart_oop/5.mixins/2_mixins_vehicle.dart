// Base class for all vehicles
class Vehicle {
  String name = "Unnamed Vehicle";

  void start() => print("$name is starting.");
  void stop() => print("$name is stopping.");
}

// Mixin for Electric Vehicles, requires access to `name` property from Vehicle
mixin ElectricVehicle on Vehicle {
  int batteryLevel = 100;

  void chargeBattery() => print("$name is charging its battery...");
  
  void driveOnElectric() {
    if (batteryLevel > 0) {
      print("$name is driving on electric power. Battery level: $batteryLevel%");
    } else {
      print("$name cannot drive, battery is empty!");
    }
  }
}

// Mixin for Combustion Engine Vehicles, requires access to `name` property from Vehicle
mixin CombustionVehicle on Vehicle {
  int fuelLevel = 100;

  void refuel() => print("$name is refueling...");
  
  void driveOnFuel() {
    if (fuelLevel > 0) {
      print("$name is driving on fuel. Fuel level: $fuelLevel%");
    } else {
      print("$name cannot drive, fuel is empty!");
    }
  }
}

// Electric Car class that uses ElectricVehicle mixin
class ElectricCar extends Vehicle with ElectricVehicle {
  ElectricCar(String carName) {
    name = carName; // Assign the name of the vehicle
  }

  void display() => print("I am an Electric Car named $name.");
}

// Combustion Car class that uses CombustionVehicle mixin
class CombustionCar extends Vehicle with CombustionVehicle {
  CombustionCar(String carName) {
    name = carName; // Assign the name of the vehicle
  }

  void display() => print("I am a Combustion Engine Car named $name.");
}

// Hybrid Car class that uses both ElectricVehicle and CombustionVehicle mixins
class HybridCar extends Vehicle with ElectricVehicle, CombustionVehicle {
  HybridCar(String carName) {
    name = carName; // Assign the name of the vehicle
  }

  void display() => print("I am a Hybrid Car named $name.");
  
  // Method to manage both battery and fuel usage
  void driveHybrid() {
    if (batteryLevel > 0) {
      driveOnElectric();
    } else if (fuelLevel > 0) {
      driveOnFuel();
    } else {
      print("$name cannot drive, both battery and fuel are empty!");
    }
  }
}

void main() {
  // Electric Car example
  var electricCar = ElectricCar("Tesla Model 3");
  electricCar.display();
  electricCar.start();
  electricCar.chargeBattery();
  electricCar.driveOnElectric();
  electricCar.stop();

  print(""); // Line break

  // Combustion Car example
  var combustionCar = CombustionCar("Toyota Corolla");
  combustionCar.display();
  combustionCar.start();
  combustionCar.refuel();
  combustionCar.driveOnFuel();
  combustionCar.stop();

  print(""); // Line break

  // Hybrid Car example
  var hybridCar = HybridCar("Toyota Prius");
  hybridCar.display();
  hybridCar.start();
  hybridCar.chargeBattery();
  hybridCar.refuel();
  hybridCar.driveHybrid();
  hybridCar.stop();
}
