// Deconstructing Records: Patterns help destructure records
// to access their values in a concise way

void printCoordinates((double, double) point) {
  // record (double, double) is deconstructed directly
  // within the switch statement to access lat and long values
  switch (point) {
    case (var lat, var long):
      print('lat: $lat, long: $long');
  }
}

void main() {
  var point = (10.553, 21.562);
  printCoordinates(point);
}
