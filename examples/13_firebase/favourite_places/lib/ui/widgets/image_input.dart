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

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera, //ImageSource.gallery,
      maxWidth: double.infinity,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _selectedImage = File(pickedImage.path);
    });

    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _takePicture,
      label: const Text('Take Picture'),
      icon: const Icon(Icons.camera_alt_outlined),
    );

    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: widget.isAdding ? null : _takePicture,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    } else if (widget.initialImage != null) {
      content = GestureDetector(
        onTap: widget.isAdding ? null : _takePicture,
        child: Image.network(
          widget.initialImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
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
