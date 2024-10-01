import 'package:flutter/material.dart';

class ColorSlider extends StatelessWidget {
  final String colorName;
  final double colorValue;
  final ValueChanged<double> onValueChange;

  const ColorSlider({
    required this.colorName,
    required this.colorValue,
    required this.onValueChange
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(colorName),
        ),
        Expanded(
          flex: 8,
          child: Slider(
            value: colorValue,
            onChanged: onValueChange,
            min: 0,
            max: 255,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(colorValue.round().toString()),
        ),
      ],
    );
  }
}
