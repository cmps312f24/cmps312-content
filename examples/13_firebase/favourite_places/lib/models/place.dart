import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  final double latitude;
  final double longitude;
  final String address;
}

class Place {
  Place(
      {required this.placeName,
      required this.image,
      required this.location,
      String? id})
      : id = id ?? uuid.v4();

  final String id;
  final String placeName;
  final String image;
  final PlaceLocation location;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'placeName': placeName,
      'image': image,
      'location': {
        'latitude': location.latitude,
        'longitude': location.longitude,
        'address': location.address,
      }
    };
  }

  static Place fromJson(Map<String, dynamic> data) {
    final location = PlaceLocation(
        latitude: data['location']['latitude'],
        longitude: data['location']['longitude'],
        address: data['location']['address']);

    return Place(
        id: data['id'],
        placeName: data['placeName'],
        image: data['image'],
        location: location);
  }
}
