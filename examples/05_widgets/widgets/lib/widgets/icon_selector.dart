import 'package:flutter/material.dart';
import 'package:widgets/models/icon_label.dart';

class IconSelector extends StatelessWidget {
  final ValueChanged<IconLabel?> onSelected;

  const IconSelector({
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<IconLabel>(
      enableFilter: true,
      requestFocusOnTap: true,
      label: const Text('Icon'),
      onSelected: onSelected,
      dropdownMenuEntries: IconLabel.values.map((IconLabel icon) {
        return DropdownMenuEntry<IconLabel>(
          value: icon,
          label: icon.label,
          leadingIcon: Icon(icon.icon),
        );
      }).toList(),
    );
  }
}
