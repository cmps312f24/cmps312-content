// Use record pattern to destructure a record to access their values 
// in a concise way

String pointToString(({double latitude, double longitude}) point) {
  // Using switch case to destructure the record allows
  // validating the record structure before extracting values
  // and assigning them to variables
  return switch (point) {
    (latitude: var lat, longitude: var long) => 'lat: $lat, long: $long'
  };
}

void main() {
  // A record with latitude and longitude named fields
  var point = (latitude: 10.553, longitude: 21.562);

  // Deconstructing the record to extract latitude and longitude
  var (:latitude, :longitude) = point;
  print('lat: $latitude, long: $longitude');
  // or also assign them to lat and long variables respectively
  var (latitude: lat, longitude: long) = point;
  print('lat: $lat, long: $long');

  var location = pointToString(point);
  print('Location: $location');
}
