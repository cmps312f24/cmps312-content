// Function returning coordinates as a record with named fields
/*
  getCoordinates() returns a record with named fields 
    (lat and lon), making the code more readable and 
    self-explanatory.
*/
({double lat, double long}) getCoordinates() {
  double latitude = 25.276987;
  double longitude = 51.520008;
  // Return a record with named fields
  return (lat: latitude, long: longitude); 
}

void main() {
  // Extract the latitude and longitude from the record
  var coordinates = getCoordinates();

  print("Latitude: ${coordinates.lat}");
  print("Longitude: ${coordinates.long}");
}
