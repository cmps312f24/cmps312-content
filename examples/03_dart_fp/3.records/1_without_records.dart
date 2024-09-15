// Define the Location class
class Location {
  final double latitude;
  final double longitude;

  // Constructor for initializing the Location object
  Location(this.latitude, this.longitude);

  // Method to display location in a formatted way
  @override
  String toString() => 'Latitude: $latitude, Longitude: $longitude';
}

// Function returning an instance of Location
Location getCoordinates() {
  double latitude = 25.276987;
  double longitude = 51.520008;
  return Location(latitude, longitude);  // Return a Location object
}

void main() {
  // Get the location object
  Location location = getCoordinates();
  
  // Access latitude and longitude from the Location object
  print(location);  // Using the toString method for formatted output
  print("Latitude: ${location.latitude}");
  print("Longitude: ${location.longitude}");
}
