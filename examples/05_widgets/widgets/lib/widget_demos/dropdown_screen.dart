import 'package:flutter/material.dart';
import 'package:widgets/models/color_label.dart';
import 'package:widgets/models/icon_label.dart';
import 'package:widgets/widgets/color_selector.dart';
import 'package:widgets/widgets/country_selector.dart';
import 'package:widgets/widgets/icon_selector.dart';

class DropdownMenuScreen extends StatefulWidget {
  const DropdownMenuScreen();

  @override
  State<DropdownMenuScreen> createState() => _DropdownMenuScreenState();
}

class _DropdownMenuScreenState extends State<DropdownMenuScreen> {
  String selectedCountry = 'Qatar';
  ColorLabel? selectedColor = ColorLabel.green;
  IconLabel? selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DropdownMenu Demo'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 12),
          CountrySelector(
              initialValue: selectedCountry,
              onSelected: (String newValue) {
                setState(() {
                  selectedCountry = newValue;
                });
              }),
          const SizedBox(width: 12),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ColorSelector(
                  initialColor: selectedColor ?? ColorLabel.green,
                  onSelected: (ColorLabel? color) {
                    setState(() {
                      if (color != null) {
                        selectedColor = color;
                      }
                    });
                  },
                ),
                const SizedBox(width: 24),
                IconSelector(
                  onSelected: (IconLabel? icon) {
                    setState(() {
                      selectedIcon = icon;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text('You selected $selectedCountry'),
          const SizedBox(height: 12),
          if (selectedColor != null && selectedIcon != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'You selected a ${selectedColor?.label} ${selectedIcon?.label}'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Icon(
                    selectedIcon?.icon,
                    color: selectedColor?.color,
                  ),
                )
              ],
            )
          else
            const Text('Please select a color and an icon.')
        ],
      ),
    );
  }
}

/*class DropdownMenuScreen extends StatelessWidget {
  const DropdownMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dropdown Demo'),
        centerTitle: true,
      ),
      body: const Column(
        children: [
          CountrySelector(),
          ColorSelector(),
        ],
      ),
    );
  }
}*/

