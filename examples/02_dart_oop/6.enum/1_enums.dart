enum Color { white, black }
enum Weekday { monday, tuesday, wednesday, thursday, friday }
enum PlanetType { terrestrial, gas, ice }
enum Weather { sunny, cloudy, rainy }

void main() {
  Color c = Color.black;
  Weekday d = Weekday.values[Weekday.friday.index];
  Weather w = Weather.sunny;
  
  if (c == Color.black && d == Weekday.friday && w == Weather.sunny) {
    print("Let's go shopping!");
  } if (w == Weather.rainy) {
    print("Stay at home!");
  } else {
    print("Wait for good deals! and good weather!");
  }

  for (var planet in PlanetType.values) {
    print(planet);
  }
}