import 'package:flutter/material.dart';
import 'package:widgets/models/color_label.dart';

class ColorSelector extends StatelessWidget {
  final ColorLabel initialColor;
  final ValueChanged<ColorLabel?> onSelected;

  const ColorSelector({
    this.initialColor = ColorLabel.green,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<ColorLabel>(
      initialSelection: initialColor,
      label: const Text('Color'),
      onSelected: onSelected,
      dropdownMenuEntries: ColorLabel.values.map((ColorLabel color) {
        return DropdownMenuEntry<ColorLabel>(
          value: color,
          label: color.label,
          style: MenuItemButton.styleFrom(
            foregroundColor: color.color,
          ),
        );
      }).toList(),
    );
  }
}
