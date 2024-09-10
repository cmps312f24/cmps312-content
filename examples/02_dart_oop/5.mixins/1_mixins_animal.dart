// Mixin for flying ability, includes speed property
mixin CanFly {
  // Property defined in the mixin
  int flyingSpeed = 10;

  void fly() => print("I can fly at $flyingSpeed km/h!");
}

// Mixin for swimming ability, includes speed property
mixin CanSwim {
  // Property defined in the mixin
  int swimmingSpeed = 5;

  void swim() => print("I can swim at $swimmingSpeed km/h!");
}

// Base class for all animals
class Animal {
  void breathe() => print("I can breathe!");
}

// Bird class (uses CanFly mixin and accesses its property)
class Bird extends Animal with CanFly {
  void chirp() => print("I am chirping.");

  // Modifying flyingSpeed from mixin
  void setFlyingSpeed(int speed) {
    flyingSpeed = speed;
  }
}

// Fish class (uses CanSwim mixin and accesses its property)
class Fish extends Animal with CanSwim {
  void display() => print("I am a fish.");

  // Modifying swimmingSpeed from mixin
  void setSwimmingSpeed(int speed) {
    swimmingSpeed = speed;
  }
}

// Duck class (uses both CanFly and CanSwim mixins)
class Duck extends Animal with CanFly, CanSwim {
  void quack() => print("I am quacking.");

  // Modify both flyingSpeed and swimmingSpeed from mixins
  void setSpeeds(int flySpeed, int swimSpeed) {
    flyingSpeed = flySpeed;
    swimmingSpeed = swimSpeed;
  }
}

void main() {
  // Bird example
  var bird = Bird();
  bird.setFlyingSpeed(20); // Set flying speed for the bird
  print("Bird:");
  bird.breathe();
  bird.fly();
  bird.chirp();
  print(""); // Line break

  // Fish example
  var fish = Fish();
  fish.setSwimmingSpeed(8); // Set swimming speed for the fish
  print("Fish:");
  fish.breathe();
  fish.swim();
  fish.display();
  print(""); // Line break

  // Duck example
  var duck = Duck();
  duck.setSpeeds(15, 10); // Set both flying and swimming speeds for the duck
  print("Duck:");
  duck.breathe();
  duck.fly();
  duck.swim();
  duck.quack();
}
