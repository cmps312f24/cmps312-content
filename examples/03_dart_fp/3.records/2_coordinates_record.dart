// Function returning coordinates as a record containing 
// two double values: latitude and longitude.
(double, double) getCoordinates() {
  double latitude = 25.276987;
  double longitude = 51.520008;
  return (latitude, longitude);  // Return a record with two positional fields
}

void main() {
  var coordinates = getCoordinates();
  
  print("Latitude: ${coordinates.$1}");
  print("Latitude: ${coordinates.$2}");

  // Extract the latitude and longitude from the record
  // The values are unpacked using var (latitude, longitude) 
  // for easy access to data returned from the function.
  var (latitude, longitude) = (25.276987, 51.520008);
  (latitude, longitude) = getCoordinates();
  print("Latitude: $latitude");
  print("Longitude: $longitude");
}
