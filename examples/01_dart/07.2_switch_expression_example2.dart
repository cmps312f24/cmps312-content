abstract class Animal {
  String get name;
}

class Dog extends Animal {
  @override
  String get name => 'Spot';
}

class Cat extends Animal {
    @override
  String get name => 'Garfield';
}

void main() {
  Animal pet = Dog();

  final sound = switch (pet) {
    (Dog d) => '${d.name}: Woof!',
    (Cat c) => '${c.name}: Meow!',
    _ => '...',
  };
  print(sound);
}