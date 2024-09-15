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
  print('Bird example');
  var bird = Bird()
    ..setFlyingSpeed(20)
    ..breathe()
    ..fly()
    ..chirp();

  print('\nFish example');
  var fish = Fish()
    ..setSwimmingSpeed(8)
    ..breathe()
    ..swim()
    ..display();

  print('\nDuck example');
  var duck = Duck()
    ..setSpeeds(15, 10)
    ..breathe()
    ..fly()
    ..swim()
    ..quack();
}
