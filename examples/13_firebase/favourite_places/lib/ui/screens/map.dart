import 'package:favourite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  MapScreen({
    super.key,
    // QU Coordinates
    this.location = const PlaceLocation(
      latitude: 25.3773256,
      longitude: 51.4911738,
      address: 'University St, Doha, Qatar',
    ),
    this.isSelecting = true,
    this.initialLocation,
  });

  PlaceLocation location;
  PlaceLocation? initialLocation;
  final bool isSelecting;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  @override
  void initState() {
    super.initState();

  if (widget.initialLocation != null) {
    widget.location = widget.initialLocation!;
      _pickedLocation = LatLng(
        widget.initialLocation!.latitude,
        widget.initialLocation!.longitude,
      );  
  }
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isSelecting ? 'Pick Your Location' : 'Your Location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(_pickedLocation);
              },
              icon: const Icon(Icons.save),
            ),
        ],
      ),
      body: GoogleMap(
        onTap: !widget.isSelecting
            ? null
            : (location) {
                setState(() {
                  _pickedLocation = location;
                });
              },
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.location.latitude, widget.location.longitude),
          zoom: 16,
        ),
        markers: (_pickedLocation == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                    markerId: const MarkerId('m1'),
                    position: _pickedLocation ??
                        LatLng(widget.location.latitude,
                            widget.location.longitude),
                    infoWindow: const InfoWindow(title: 'Your location.'))
              },
      ),
    );
  }
}
