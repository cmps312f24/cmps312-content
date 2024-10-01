import 'package:flutter/material.dart';

class Greeting extends StatelessWidget {
  final String name;
  const Greeting({required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Hello, $name!',
      //style: Theme.of(context).primaryTextTheme.bodyMedium
      style: const TextStyle(
        decoration: TextDecoration.none,
        color: Colors.blue,
        fontSize: 30.0,
      ),
    );
  }
}
