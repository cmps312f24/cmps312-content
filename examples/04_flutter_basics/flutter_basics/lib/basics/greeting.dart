import 'package:flutter/material.dart';

class Greeting extends StatelessWidget {
  final String name;

  const Greeting({required this.name});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Text(
      'Salam $name! ${mediaQuery.size.width}',
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }
}
