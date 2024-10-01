import 'package:flutter/material.dart';

class CountrySelector extends StatelessWidget {
  final String initialValue;
  final ValueChanged<String> onSelected;

  CountrySelector({required this.initialValue, required this.onSelected});

  final List<String> countries = [
    "Australia",
    "Qatar",
    "Japan",
    "United States",
    "India",
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: initialValue,
      label: const Text('Select a country'),
      onSelected: (String? newValue) {
        if (newValue != null) {
          onSelected(newValue);
        }
      },
      dropdownMenuEntries:
          countries.map<DropdownMenuEntry<String>>((String country) {
        return DropdownMenuEntry<String>(
          value: country,
          label: country,
        );
      }).toList(),
    );
  }
}
