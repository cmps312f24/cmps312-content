import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: Colors.green.shade900,
  appBarTheme: const AppBarTheme(
    color: Color.fromARGB(255, 25, 97, 27),
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.amber),
    bodyLarge: TextStyle(color: Colors.white, fontSize: 16.0),
    bodyMedium: TextStyle(color: Colors.white70, fontSize: 14.0),
  ),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
      .copyWith(secondary: Colors.amber),
  // Define any other theme properties as needed
);
