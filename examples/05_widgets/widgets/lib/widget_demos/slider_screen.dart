import 'package:flutter/material.dart';
import 'package:widgets/widgets/color_slider.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});

  @override
  _SliderScreenState createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  double red = 152;
  double blue = 251;
  double green = 152;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slider Screen'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ColorSlider(
            colorName: 'Red',
            colorValue: red,
            onValueChange: (value) {
              setState(() {
                red = value;
              });
            },
          ),
          ColorSlider(
            colorName: 'Blue',
            colorValue: blue,
            onValueChange: (value) {
              setState(() {
                blue = value;
              });
            },
          ),
          ColorSlider(
            colorName: 'Green',
            colorValue: green,
            onValueChange: (value) {
              setState(() {
                green = value;
              });
            },
          ),
          Expanded(
            child: Container(
              color: Color.fromRGBO(
                red.toInt(),
                green.toInt(),
                blue.toInt(),
                1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
