import 'package:flutter/material.dart';

class CheckBoxScreen extends StatelessWidget {
  CheckBoxScreen({super.key});

  final options = {
    'Java': false,
    'Dart': true,
    'Kotlin': true,
    'JavaScript': true,
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CheckBox Screen'),
        ),
        body: FavoriteLanguagesScreen(languageOptions: options),
      ),
    );
  }
}

class FavoriteLanguagesScreen extends StatefulWidget {
  final Map<String, bool> languageOptions;
  const FavoriteLanguagesScreen({required this.languageOptions});
  @override
  _FavoriteLanguagesScreenState createState() =>
      _FavoriteLanguagesScreenState(languageOptions: languageOptions);
}

class _FavoriteLanguagesScreenState extends State<FavoriteLanguagesScreen> {
  final Map<String, bool> languageOptions;
  _FavoriteLanguagesScreenState({required this.languageOptions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Which are your most favorite language?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          ...languageOptions.keys.map((String key) {
            return CheckboxListTile(
              title: Text(key),
              value: languageOptions[key],
              onChanged: (bool? value) {
                setState(() {
                  languageOptions[key] = value!;
                });
              },
            );
          }),
          const SizedBox(height: 15.0),
          Center(
            child: Text(
              languageOptions.entries
                  .map((entry) => '${entry.key} (${entry.value})')
                  .join('\n'),
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
