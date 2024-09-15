(String, double, {double windSpeed, String condition}) fetchWeather() {
  // Simulate API response
  String city = "Doha";
  double temperature = 36.5;
  double windSpeed = 5.4;
  String condition = "Clear";
  
  return (city, temperature, windSpeed: windSpeed, condition: condition);
}

void main() {
  // Extract the data from the record
  var (city, temperature, windSpeed: wind, condition: cond) = fetchWeather();
  print("City: $city");
  print("Temperature: $temperature°C");
  print("Wind Speed: $wind km/h");
  print("Condition: $cond");
}
