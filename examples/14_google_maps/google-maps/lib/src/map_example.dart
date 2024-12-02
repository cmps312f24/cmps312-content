import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const LatLng quPosition =
        LatLng(25.377, 51.491); // Qatar University location
    const double zoomLevel = 20.0; // Zoom level for buildings

    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map Example"),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: quPosition,
          zoom: zoomLevel,
        ),
        mapType: MapType.hybrid,
        myLocationEnabled: true,
        mapToolbarEnabled: true,
        zoomControlsEnabled: true,
        markers: {
          Marker(
            markerId: MarkerId('quMarker'),
            position: quPosition,
            infoWindow: InfoWindow(
              title: "QU",
              snippet: "Qatar University",
            ),
          ),
        },
        polygons: {
          Polygon(
            polygonId: PolygonId('quPolygon'),
            points: [
              LatLng(25.376, 51.490),
              LatLng(25.378, 51.490),
              LatLng(25.378, 51.492),
              LatLng(25.376, 51.492),
            ],
            fillColor: Colors.green.withOpacity(0.5),
            strokeWidth: 2,
            strokeColor: Colors.green,
          ),
        },
        circles: {
          Circle(
            circleId: CircleId('quCircle'),
            center: quPosition,
            radius: 500,
            fillColor: Colors.blue.withOpacity(0.5),
            strokeWidth: 2,
            strokeColor: Colors.blue,
          ),
        },
        onMapCreated: (GoogleMapController controller) {
          // Additional map setup if needed
        },
      ),
    );
  }
}
