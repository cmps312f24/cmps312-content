import 'dart:io';

import 'package:favourite_places/utils/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favourite_places/providers/user_places.dart';
import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/ui/widgets/image_input.dart';
import 'package:favourite_places/ui/widgets/location_input.dart';

class EditPlace extends ConsumerStatefulWidget {
  const EditPlace({super.key, required this.place});

  final Place place;

  @override
  ConsumerState<EditPlace> createState() {
    return _EditPlaceState();
  }
}

class _EditPlaceState extends ConsumerState<EditPlace> {
  File? _selectedImage;
  String? _initialImage;
  PlaceLocation? _location;
  PlaceLocation? _initialLocation;
  bool _isUpdating = false;

  final _placeName = TextEditingController();

  Future _updatePlace() async {
    final enteredPlace = _placeName.text;

    if (enteredPlace.isEmpty ||
        (_selectedImage == null && _initialImage == null) ||
        _location == null) {
      ErrorHandler.showMessage(context, 'All fiels are mandatory');
      return;
    }

    setState(() {
      _isUpdating = true;
    });

    if (_selectedImage == null) {
      await ref.read(userPlacesProvider.notifier).updatePlace(
            id: widget.place.id,
            title: enteredPlace,
            location: _location!,
            initialImage: _initialImage,
            context: context,
          );
    } else {
      await ref.read(userPlacesProvider.notifier).updatePlace(
            id: widget.place.id,
            title: enteredPlace,
            location: _location!,
            image: _selectedImage,
            context: context,
          );
    }

    setState(() {
      _isUpdating = false;
    });

    Navigator.of(context).pop();
    ErrorHandler.showMessage(context, 'Place Updated Successfully.');
  }

  @override
  void initState() {
    super.initState();

    final data = widget.place;
    _placeName.text = data.placeName;
    _initialImage = data.image;
    _initialLocation = PlaceLocation(
        latitude: data.location.latitude,
        longitude: data.location.longitude,
        address: data.location.address);
  }

  @override
  void dispose() {
    super.dispose();

    _placeName.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          'Edit Place',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Column(
                children: [
                  TextField(
                    controller: _placeName,
                    decoration: const InputDecoration(
                      labelText: 'Place Name',
                    ),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ImageInput(
                    isAdding: _isUpdating,
                    initialImage: _initialImage,
                    onPickImage: (image) {
                      _selectedImage = image;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  LocationInput(
                    isAdding: _isUpdating,
                    initialLocation: _initialLocation,
                    onSelectCurrentLocation: (currentLocation) {
                      _location = currentLocation;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton.icon(
                    onPressed: _isUpdating ? null : _updatePlace,
                    icon: _isUpdating
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.save),
                    label: _isUpdating
                        ? const Text('Saving...')
                        : const Text('Save Changes'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150, 40),
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
