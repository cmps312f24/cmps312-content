import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key});

  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _imageFile;
  bool _isUploading = false;

  // Pick an image from the gallery
  Future<void> pickImage(ImageSource source) async {
    try {
      if (Platform.isAndroid) {
        await requestPermission();
      }

      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          _imageFile = File(image.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  // Upload the selected image to Supabase storage
  Future<void> uploadImage() async {
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image first.')),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final path = '/$fileName';

      var uploadPath = await Supabase.instance.client.storage
          .from('images') // Replace 'images' with your bucket name
          .upload(path, _imageFile!);

      final publicUrl = Supabase.instance.client.storage
          .from('images') // Replace 'images' with your bucket name
          .getPublicUrl(uploadPath);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image uploaded successfully! URL: $publicUrl')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  Future<void> requestPermission() async {
    if (Platform.isAndroid) {
      if (await Permission.photos.isDenied ||
          await Permission.photos.isPermanentlyDenied) {
        await Permission.photos.request();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Supabase Storage")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              color: Colors.lightBlue,
              onPressed: () => pickImage(ImageSource.camera),
              child: const Text('From Camera'),
            ),
            MaterialButton(
              color: Colors.lightBlue,
              onPressed: () => pickImage(ImageSource.gallery),
              child: const Text('From Gallery'),
            ),
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: _imageFile != null
                  ? Image.file(
                      _imageFile!,
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.fitHeight,
                    )
                  : const Text("Pick an image from gallery or camera"),
            ),
/*             CircleAvatar(
              radius: 50,
              backgroundImage:
                  _imageFile != null ? FileImage(_imageFile!) : null,
              child: _imageFile == null
                  ? const Icon(Icons.person, size: 50)
                  : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Pick Image'),
              onPressed: () => pickImage(ImageSource.gallery),
            ),
            ElevatedButton(
              child: const Text('Take Photo'),
              onPressed: () => pickImage(ImageSource.camera),
            ), */
            ElevatedButton(
              onPressed: _isUploading ? null : uploadImage,
              child: _isUploading
                  ? const CircularProgressIndicator()
                  : const Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
