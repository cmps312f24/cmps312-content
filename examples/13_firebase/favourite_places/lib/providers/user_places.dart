import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favourite_places/services/firestore_db.dart';
import 'package:favourite_places/models/place.dart';

final _database = DatabaseService();

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  Future getPlaces() async {
    state = await _database.getPlaces();
  }

  Future addPlace(String title, File image, PlaceLocation location,
      BuildContext context) async {
    final isAdded = await _database.addPlace(title, image, location, context);

    if (isAdded.isNotEmpty) {
      final imageUrl = await _database.getImageUrl(isAdded);
      final newPlace =
          Place(placeName: title, image: imageUrl, location: location);

      state = [newPlace, ...state];
    }
  }

  Future removePlace(String id, BuildContext context) async {
    await _database.removePlace(id, context);
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
      await _database.updatePlace(
        id: id,
        name: title,
        location: location,
        initialImage: initialImage,
        context: context,
      );
    } else if (image != null) {
      await _database.updatePlace(
        id: id,
        name: title,
        location: location,
        image: image,
        context: context,
      );
    }

    final imageUrl = await _database.getImageUrl(id);

    state = state
        .map((place) => place.id == id
            ? Place(
                id: id, placeName: title, image: imageUrl, location: location)
            : place)
        .toList();
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);
