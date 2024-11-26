import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/utils/error_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late final CollectionReference _places;
  late final Reference _storageRef;

  DatabaseService() {
    _places = _db.collection('places');
    _storageRef = FirebaseStorage.instance.ref().child('place_images');
  }

  Future<List<Place>> getPlaces() async {
    try {
      QuerySnapshot queryResults = await _places.get();

      List<Place> places = queryResults.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Place.fromMap(data);
      }).toList();
      return places;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String> addPlace(String name, File image, PlaceLocation location,
      BuildContext context) async {
    if (name.isEmpty ||
        image.path.isEmpty ||
        location.latitude == 0.0 ||
        location.longitude == 0.0 ||
        location.address.isEmpty) {
      ErrorHandler.showMessage(context, 'Invalid data: Some fields are empty.');
    }

    try {
      final docRef = _places.doc();
      final generatedId = docRef.id;

      final imageRef = _storageRef.child(generatedId);
      await imageRef.putFile(image);
      final imageUrl = await imageRef.getDownloadURL();

      final place = Place(
          id: generatedId,
          placeName: name,
          image: imageUrl,
          location: location);

      Map<String, dynamic> placeMap = place.toMap();

      await _places.doc(place.id).set(placeMap);
      return place.id;
    } catch (e) {
      if (e is FirebaseException) {
        String errorMessage = ErrorHandler.getErrorMessage(e);
        ErrorHandler.showMessage(context, errorMessage);
      } else {
        ErrorHandler.showMessage(
            context, 'Something went wrong. Please try again later.');
      }

      return '';
    }
  }

  Future<String> getImageUrl(String id) async {
    try {
      final imageUrl = await _storageRef.child(id).getDownloadURL();
      return imageUrl;
    } catch (e) {
      throw ('Failed to fetch image URL: $e');
    }
  }

  Future removePlace(String id, BuildContext context) async {
    try {
      if (id.isEmpty) return;

      await _places.doc(id).delete();
      await _storageRef.child(id).delete();
    } catch (e) {
      if (e is FirebaseException) {
        String errorMessage = ErrorHandler.getErrorMessage(e);
        ErrorHandler.showMessage(context, errorMessage);
      } else {
        ErrorHandler.showMessage(
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
          final newImageRef = _storageRef.child(id);
          await newImageRef.putFile(image);
          imageUrl = await newImageRef.getDownloadURL();
        }
      }

      // Update Firestore document
      final updatedData = Place(
        id: id,
        placeName: name,
        image: imageUrl,
        location: location,
      );

      await _places.doc(id).update(updatedData.toMap());
    } catch (e) {
      if (e is FirebaseException) {
        String errorMessage = ErrorHandler.getErrorMessage(e);
        ErrorHandler.showMessage(context!, errorMessage);
      } else {
        ErrorHandler.showMessage(
            context!, 'Something went wrong. Please try again later.');
      }
    }
  }
}
