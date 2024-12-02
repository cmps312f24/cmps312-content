import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/services/storage_service.dart';
import 'package:favourite_places/utils/error_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirestoreDB {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late final CollectionReference _places;
  late final StorageService _storageService;

  FirestoreDB() {
    _places = _db.collection('places');
    _storageService = StorageService();
  }

  Stream<List<Place>> observePlaces() =>
      _places.snapshots().map((snapshot) => snapshot.docs
          .map((doc) => Place.fromJson(doc.data() as Map<String, dynamic>))
          .toList());

  Future<String> addPlace(
      String name, File image, PlaceLocation location) async {
    final docRef = _places.doc();
    final generatedId = docRef.id;

    final imageUrl = await _storageService.uploadFile(generatedId, image);

    final place = Place(
        id: generatedId, placeName: name, image: imageUrl, location: location);

    await _places.doc(place.id).set(place.toJson());
    return place.id;
  }



  Future removePlace(String id, BuildContext context) async {
    try {
      if (id.isEmpty) return;

      await _places.doc(id).delete();
      await _storageService.deleteFile(id);
    } catch (e) {
      if (e is FirebaseException) {
        String errorMessage = MessageHelper.getErrorMessage(e);
        MessageHelper.showMessage(context, errorMessage);
      } else {
        MessageHelper.showMessage(
            context, 'Something went wrong. Please try again later.');
      }

      return '';
    }
  }

  Future updatePlace({
    required String id,
    required String name,
    required PlaceLocation location,
    File? image,
    String? initialImage,
    BuildContext? context,
  }) async {
    if (name.isEmpty ||
        initialImage == null ||
        location.latitude == 0.0 ||
        location.longitude == 0.0 ||
        location.address.isEmpty) {
      throw Exception('Invalid data: Some fields are empty.');
    }

    try {
      String imageUrl = initialImage;

      if (image != null) {
        if (imageUrl.isNotEmpty) {
          // Delete existing image
          final currentImageRef = FirebaseStorage.instance.refFromURL(imageUrl);
          await currentImageRef.delete();

          // Upload new image
          imageUrl = await _storageService.uploadFile(id, image);
        }
      }

      // Update Firestore document
      final updatedData = Place(
        id: id,
        placeName: name,
        image: imageUrl,
        location: location,
      );

      await _places.doc(id).update(updatedData.toJson());
    } catch (e) {
      if (e is FirebaseException) {
        String errorMessage = MessageHelper.getErrorMessage(e);
        MessageHelper.showMessage(context!, errorMessage);
      } else {
        MessageHelper.showMessage(
            context!, 'Something went wrong. Please try again later.');
      }
    }
  }
}
