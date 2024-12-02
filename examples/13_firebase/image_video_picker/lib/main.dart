import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_video_picker/video_player_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const PickImageVideo(),
    );
  }
}

class PickImageVideo extends StatefulWidget {
  const PickImageVideo({Key? key}) : super(key: key);

  @override
  State<PickImageVideo> createState() => _PickImageVideoState();
}

class _PickImageVideoState extends State<PickImageVideo> {
  var _image;
  var _video;
  var imagePicker;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

//Selecting multiple images from Gallery
  List<XFile>? imageFileList = [];
  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    setState(() {});
  }

  void pickImageFromGallery() async {
    XFile image = await imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
    setState(() {
      _image = File(image.path);
    });
  }

  void pickImageFromCamera() async {
    XFile image = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    setState(() {
      _image = File(image.path);
    });
  }

  void pickVideoFromGallery() async {
    XFile _video = await imagePicker.pickVideo(source: ImageSource.gallery);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) => VideoPlayerScreen(
          videopath: _video.path,
        ),
      ),
    );
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Picker"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            MaterialButton(
              color: Colors.lightBlue,
              onPressed: () {
                pickImageFromGallery();
              },
              child: const Text('From Camera'),
            ),
            MaterialButton(
              color: Colors.lightBlue,
              onPressed: () {
                pickImageFromCamera();
              },
              child: const Text('From Gallery'),
            ),
            MaterialButton(
              color: Colors.lightBlue,
              onPressed: () {
                pickVideoFromGallery();
              },
              child: const Text("Select video from Gallery"),
            ),
            MaterialButton(
              color: Colors.lightBlue,
              onPressed: () {
                selectImages();
              },
              child: const Text('Select Multiple Images'),
            ),
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: _image != null
                  ? Image.file(
                      _image,
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.fitHeight,
                    )
                  : const Text("Pick an image from gallery or click"),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: imageFileList!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Image.file(
                        File(imageFileList![index].path),
                        height: 300,
                        width: 300,
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
