import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapMarkersCluster extends StatefulWidget {
  @override
  _GoogleMapMarkersClusterState createState() =>
      _GoogleMapMarkersClusterState();
}

class _GoogleMapMarkersClusterState extends State<GoogleMapMarkersCluster> {
  late GoogleMapController _controller;

  final List<LatLng> parkMarkers = [
    LatLng(25.276987, 55.296249), // Example marker positions
    LatLng(25.285446, 51.531040),
    LatLng(25.317649, 55.412058),
  ];

  LatLng? selectedMarker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clustering Map Example')),
      body: GoogleMap(
        onMapCreated: (controller) {
          _controller = controller;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(25.276987, 55.296249),
          zoom: 10.0,
        ),
        markers: _createMarkers(),
        circles: _createCircles(),
      ),
    );
  }

  Set<Marker> _createMarkers() {
    Set<Marker> markers = {};
    for (var position in parkMarkers) {
      markers.add(
        Marker(
          markerId: MarkerId(position.toString()),
          position: position,
          onTap: () {
            setState(() {
              selectedMarker = position;
              // Additional logic can be added here when a marker is tapped
            });
          },
        ),
      );
    }
    return markers;
  }

  Set<Circle> _createCircles() {
    return parkMarkers.map((position) {
      return Circle(
        circleId: CircleId(position.toString()),
        center: position,
        radius: 2000.0,
        fillColor: Colors.green.withOpacity(0.5),
        strokeColor: Colors.green,
        strokeWidth: 2,
      );
    }).toSet();
  }
}
