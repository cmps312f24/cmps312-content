Stream<int> temperatureStream() {
  return Stream.periodic(Duration(seconds: 1), (count) => 25 + count % 5);
}

void main() {
  final tempUpdates = temperatureStream();
  tempUpdates.listen((temp) {
    print("Current temperature: $temp°C");
  });
}
