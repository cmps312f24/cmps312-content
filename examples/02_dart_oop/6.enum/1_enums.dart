enum Color { white, black }
enum Weekday { sunday, monday, tuesday, wednesday, thursday }
enum PlanetType { terrestrial, gas, ice }
enum Weather { sunny, cloudy, rainy }

void main() {
  var today = "sunday";
  var day = Weekday.sunday;

  switch(today) {

  }

  switch(day) {
    case Weekday.sunday:
      print("Today is Sunday.");
    case Weekday.monday:
      print("Today is Monday.");
    case Weekday.tuesday:
      print("Today is Tuesday.");

    case Weekday.wednesday:
      print("Today is Wednesday.");
      break;
    default:
      print("Today is Thursday.");
      break;

  }


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