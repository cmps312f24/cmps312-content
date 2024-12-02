import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({
    super.key,
    required this.onPickImage,
    this.initialImage,
    required this.isAdding,
  });

  final void Function(File) onPickImage;
  final String? initialImage;
  final bool isAdding;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  // Helper function to pick an image from the specified source 
  // (camera or gallery)
  Future<void> _pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: source, // camera or gallery
      maxWidth: double.infinity,
    );

    if (pickedImage == null) return;

    setState(() {
      _selectedImage = File(pickedImage.path);
    });

    widget.onPickImage(_selectedImage!);
  }

  // Function to show the image source selection dialog
  Future<void> _showImageSourceDialog() async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Choose Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: const Text('Take Picture'),
              onTap: () {
                Navigator.of(ctx).pop();
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Pick Image from Gallery'),
              onTap: () {
                Navigator.of(ctx).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    // Display selected image if available
    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: widget.isAdding ? null : _showImageSourceDialog,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    // Display initial image if no image is selected
    else if (widget.initialImage != null) {
      content = GestureDetector(
        onTap: widget.isAdding ? null : _showImageSourceDialog,
        child: Image.network(
          widget.initialImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    // Display button to take picture if no image is available
    else {
      content = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton.icon(
            onPressed: () => _pickImage(ImageSource.camera),
            label: const Text('Take Picture'),
            icon: const Icon(Icons.photo_camera_outlined),
          ),
          TextButton.icon(
            onPressed: () => _pickImage(ImageSource.gallery),
            label: const Text('Pick Image from Gallery'),
            icon: const Icon(Icons.photo_library_outlined),
          ),
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}
