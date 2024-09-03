enum PlanetType { terrestrial, gas, ice }

void main() {
  for (var planet in PlanetType.values) {
    print(planet);
  }
}