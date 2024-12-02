import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocationMap extends StatefulWidget {
  @override
  _CurrentLocationMapState createState() => _CurrentLocationMapState();
}

class _CurrentLocationMapState extends State<CurrentLocationMap> {
  late GoogleMapController _mapController;
  late CameraPosition _initialCameraPosition;
  LatLng? _currentLocation;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _initialCameraPosition = CameraPosition(
      target: LatLng(25.276987, 51.520008), // Default position (Doha)
      zoom: 14,
    );
    _getCurrentLocation();
  }

  // Fetch the current location using Geolocator
  Future<void> _getCurrentLocation() async {
    try {
      // Request location permission
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        print("Location permissions are denied.");
        return;
      }

      // Get the last known location
      Position? position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      if (position != null) {
        setState(() {
          _currentLocation = LatLng(position.latitude, position.longitude);
          _markers.add(
            Marker(
              markerId: MarkerId('current_location'),
              position: _currentLocation!,
              infoWindow: InfoWindow(title: "Your Location"),
            ),
          );
          _mapController.animateCamera(CameraUpdate.newLatLng(_currentLocation!));
        });
      }
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Current Location Map')),
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        myLocationEnabled: true, // Enable showing the user's location
        myLocationButtonEnabled: true, // Enable location button
      ),
    );
  }
}
