import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  late final Reference _storageRef;

  StorageService() {
    _storageRef = FirebaseStorage.instance.ref().child('place_images');
  }

  Future<String> uploadFile(String id, File file) async {
    final imageRef = _storageRef.child(id);
    await imageRef.putFile(file);
    return await imageRef.getDownloadURL();
  }

  Future<String> getFileUrl(String id) async {
    try {
      return _storageRef.child(id).getDownloadURL();
    } catch (e) {
      throw ('Failed to fetch image URL: $e');
    }
  }

  Future<void> deleteFile(String id) async {
    try {
      await _storageRef.child(id).delete();
    } catch (e) {
      throw ('Failed to delete image: $e');
    }
  }
}