import 'package:flutter/material.dart';

class DropdownMenuScreen extends StatelessWidget {
  const DropdownMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dropdown Example'),
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
}

class CountrySelector extends StatefulWidget {
  const CountrySelector({super.key});
  @override
  _CountrySelectorState createState() => _CountrySelectorState();
}

class _CountrySelectorState extends State<CountrySelector> {
  final List<String> countries = [
    "Australia",
    "Qatar",
    "Japan",
    "United States",
    "India",
  ];

  String selectedCountry = "Qatar";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownMenu<String>(
            initialSelection: selectedCountry,
            onSelected: (String? newValue) {
              setState(() {
                selectedCountry = newValue!;
              });
            },
            dropdownMenuEntries: countries.map((String country) {
              return DropdownMenuEntry<String>(
                value: country,
                label: country,
              );
            }).toList(),
          ),
          const SizedBox(height: 8.0),
          Text('Selected country: $selectedCountry'),
        ],
      ),
    );
  }
}

// Flutter code sample for [DropdownMenu]s. The first dropdown menu
// has the default outlined border and demos using the
// [DropdownMenuEntry] style parameter to customize its appearance.
// The second dropdown menu customizes the appearance of the dropdown
// menu's text field with its [InputDecorationTheme] parameter.

// DropdownMenuEntry labels and values for the first dropdown menu.
enum ColorLabel {
  blue('Blue', Colors.blue),
  pink('Pink', Colors.pink),
  green('Green', Colors.green),
  yellow('Orange', Colors.orange),
  grey('Grey', Colors.grey);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;
}

// DropdownMenuEntry labels and values for the second dropdown menu.
enum IconLabel {
  smile('Smile', Icons.sentiment_satisfied_outlined),
  cloud('Cloud', Icons.cloud_outlined),
  brush('Brush', Icons.brush_outlined),
  heart('Heart', Icons.favorite);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}

class ColorSelector extends StatefulWidget {
  const ColorSelector({super.key});

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  //final TextEditingController colorController = TextEditingController();
  //final TextEditingController iconController = TextEditingController();
  ColorLabel? selectedColor;
  IconLabel? selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownMenu<ColorLabel>(
                initialSelection: ColorLabel.green,
                //controller: colorController,
                // requestFocusOnTap is enabled/disabled by platforms when it is null.
                // On mobile platforms, this is false by default. Setting this to true will
                // trigger focus request on the text field and virtual keyboard will appear
                // afterward. On desktop platforms however, this defaults to true.
                requestFocusOnTap: true,
                label: const Text('Color'),
                onSelected: (ColorLabel? color) {
                  setState(() {
                    selectedColor = color;
                  });
                },
                dropdownMenuEntries: ColorLabel.values
                    .map<DropdownMenuEntry<ColorLabel>>((ColorLabel color) {
                  return DropdownMenuEntry<ColorLabel>(
                    value: color,
                    label: color.label,
                    enabled: color.label != 'Grey',
                    style: MenuItemButton.styleFrom(
                      foregroundColor: color.color,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(width: 24),
              DropdownMenu<IconLabel>(
                //controller: iconController,
                enableFilter: true,
                requestFocusOnTap: true,
                leadingIcon: const Icon(Icons.search),
                label: const Text('Icon'),
                inputDecorationTheme: const InputDecorationTheme(
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                ),
                onSelected: (IconLabel? icon) {
                  setState(() {
                    selectedIcon = icon;
                  });
                },
                dropdownMenuEntries:
                    IconLabel.values.map<DropdownMenuEntry<IconLabel>>(
                  (IconLabel icon) {
                    return DropdownMenuEntry<IconLabel>(
                      value: icon,
                      label: icon.label,
                      leadingIcon: Icon(icon.icon),
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        ),
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
    );
  }
}
