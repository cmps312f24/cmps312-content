import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import 'package:favourite_places/ui/screens/map.dart';
import 'package:favourite_places/models/place.dart';

const Api_Key = 'AIzaSyC6f0scDza_L8lgaePCQyZ-d3OU6YXWrmk';

class LocationInput extends StatefulWidget {
  const LocationInput({
    super.key,
    required this.onSelectCurrentLocation,
    this.initialLocation,
    required this.isAdding,
  });

  final void Function(PlaceLocation) onSelectCurrentLocation;
  final PlaceLocation? initialLocation;
  final bool isAdding;
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  bool _isGettingLocation = false;

  String get loactionImage {
    if (_pickedLocation == null) {
      return '';
    }

    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=$Api_Key';
  }

  Future<void> savePlace(double latitude, double longitude) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$Api_Key');

    final response = await http.get(url);
    final resData = json.decode(response.body);
    final address = resData['results'][0]['formatted_address'];

    setState(() {
      _pickedLocation = PlaceLocation(
        latitude: latitude,
        longitude: longitude,
        address: address,
      );
      _isGettingLocation = false;
    });

    widget.onSelectCurrentLocation(_pickedLocation!);
  }

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();

    final lat = locationData.latitude;
    final lng = locationData.longitude;

    if (lat == null || lng == null) {
      return;
    }

    await savePlace(lat, lng);
  }

  void selectOnMap() async {
    final pickedLocation = await Navigator.push<LatLng>(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(
          initialLocation: _pickedLocation,
        ),
      ),
    );

    if (pickedLocation == null) {
      return;
    }

    await savePlace(pickedLocation.latitude, pickedLocation.longitude);
  }

  @override
  void initState() {
    super.initState();

    if (widget.initialLocation != null) {
      _pickedLocation = widget.initialLocation;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Center(
      child: Text(
        'No Location Selected',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
    );

    if (_pickedLocation != null) {
      previewContent = Image.network(
        loactionImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    if (_isGettingLocation) {
      previewContent = const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: previewContent,
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: widget.isAdding ? null : _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current Location'),
            ),
            TextButton.icon(
              onPressed: widget.isAdding ? null : selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Pick Location'),
            ),
          ],
        )
      ],
    );
  }
}
