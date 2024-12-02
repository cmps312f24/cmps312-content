import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_in_flutter/src/current_location.dart';
import 'package:google_maps_in_flutter/src/map_example.dart';
import 'package:google_maps_in_flutter/src/malls_cluster.dart';
import 'src/locations.dart' as locations;

void main() {
  //runApp(const GoogleOffices());
  runApp(const GoogleMapApp());
}

class GoogleMapApp extends StatelessWidget {
  const GoogleMapApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Map Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home:
          CurrentLocationMap(), //GoogleMapExample(), //GoogleMapMarkersCluster(),
    );
  }
}

class GoogleOffices extends StatefulWidget {
  const GoogleOffices({super.key});

  @override
  State<GoogleOffices> createState() => _GoogleOfficesState();
}

class _GoogleOfficesState extends State<GoogleOffices> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Google Office Locations'),
          elevation: 2,
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(0, 0),
            zoom: 2,
          ),
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }
}
