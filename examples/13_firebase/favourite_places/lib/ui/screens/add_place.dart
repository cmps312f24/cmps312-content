import 'dart:io';

import 'package:favourite_places/utils/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/ui/widgets/location_input.dart';
import 'package:favourite_places/providers/user_places.dart';
import 'package:favourite_places/ui/widgets/image_input.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreenState();
  }
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _placeName = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _location;
  bool isAdding = false;

  void savePlace() async {
    final enteredPlace = _placeName.text;

    if (enteredPlace.isEmpty || _selectedImage == null || _location == null) {
      ErrorHandler.showMessage(context, 'All fiels are mandatory');
      return;
    }

    setState(() {
      isAdding = true;
    });

    await ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredPlace, _selectedImage!, _location!, context);

    setState(() {
      isAdding = false;
    });

    Navigator.of(context).pop();
    ErrorHandler.showMessage(context, 'Place Added Successfully.');
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
          'Add Place',
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
                    isAdding: isAdding,
                    onPickImage: (image) {
                      _selectedImage = image;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  LocationInput(
                    isAdding: isAdding,
                    onSelectCurrentLocation: (currentLocation) {
                      _location = currentLocation;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton.icon(
                    onPressed: isAdding ? null : savePlace,
                    icon: isAdding
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white, 
                            ),
                          )
                        : const Icon(Icons.add),
                    label: isAdding
                        ? const Text('Adding...')
                        : const Text('Add Place'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(
                          150, 40),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
