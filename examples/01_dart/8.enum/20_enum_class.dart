enum PlanetType { terrestrial, gas, ice }

/*
Enhanced enum declaration of a class describing planets, 
with a defined set of constant instances, namely the planets of 
our solar system.
*/

/// Enum that enumerates the different planets in our solar system
/// and some of their properties.
enum Planet {
  mercury(planetType: PlanetType.terrestrial, moons: 0, hasRings: false),
  venus(planetType: PlanetType.terrestrial, moons: 0, hasRings: false),
  // ···
  uranus(planetType: PlanetType.ice, moons: 27, hasRings: true),
  neptune(planetType: PlanetType.ice, moons: 14, hasRings: true);

  /// A constant generating constructor
  const Planet(
      {required this.planetType, required this.moons, required this.hasRings});

  /// All instance variables are final
  final PlanetType planetType;
  final int moons;
  final bool hasRings;

  /// Enhanced enums support getters and other methods
  bool get isGiant =>
      planetType == PlanetType.gas || planetType == PlanetType.ice;
}

void main() {
  for (var planet in Planet.values) {
    print('Planet: $planet');
    print('Type: ${planet.planetType}');
    print('Moons: ${planet.moons}');
    print('Has rings: ${planet.hasRings}');
    print('Is a giant planet: ${planet.isGiant}');
  }
}
