import 'dart:io';

import 'package:favourite_places/services/storage_service.dart';
import 'package:favourite_places/utils/error_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favourite_places/services/firestore_db.dart';
import 'package:favourite_places/models/place.dart';

final _firestoreDB = FirestoreDB();
final _storageService = StorageService();

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super(const []);

  void getPlaces() {
    //return _firestoreDB.observePlaces();
    _firestoreDB.observePlaces().listen((places) {
      state = places;
    });
  }

  Future addPlace(String name, File image, PlaceLocation location,
      BuildContext context) async {
    if (name.isEmpty ||
        image.path.isEmpty ||
        location.latitude == 0.0 ||
        location.longitude == 0.0 ||
        location.address.isEmpty) {
      MessageHelper.showMessage(
          context, 'Invalid data: Some fields are empty.');
    }

    String placeId = '';
    try {
      placeId = await _firestoreDB.addPlace(name, image, location);
    } catch (e) {
      if (e is FirebaseException) {
        String errorMessage = MessageHelper.getErrorMessage(e);
        MessageHelper.showMessage(context, errorMessage);
      } else {
        MessageHelper.showMessage(
            context, 'Something went wrong. Please try again later.');
      }
    }

    if (placeId.isNotEmpty) {
      final imageUrl = await _storageService.getFileUrl(placeId);
      final newPlace =
          Place(placeName: name, image: imageUrl, location: location);

      state = [newPlace, ...state];
    }
  }

  Future removePlace(String id, BuildContext context) async {
    await _firestoreDB.removePlace(id, context);
    state = state.where((p) => p.id != id).toList();
  }

  Future updatePlace({
    required String id,
    required String title,
    required PlaceLocation location,
    File? image,
    String? initialImage,
    BuildContext? context,
  }) async {
    if (initialImage != null && initialImage.isNotEmpty) {
      await _firestoreDB.updatePlace(
        id: id,
        name: title,
        location: location,
        initialImage: initialImage,
        context: context,
      );
    } else if (image != null) {
      await _firestoreDB.updatePlace(
        id: id,
        name: title,
        location: location,
        image: image,
        context: context,
      );
    }

    final imageUrl = await _storageService.getFileUrl(id);

    state = state
        .map((place) => place.id == id
            ? Place(
                id: id, placeName: title, image: imageUrl, location: location)
            : place)
        .toList();
  }
}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Place>>(
  (ref) => PlacesNotifier(),
);
