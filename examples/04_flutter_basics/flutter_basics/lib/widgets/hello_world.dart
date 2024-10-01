import 'package:flutter/material.dart';

class HelloWorld extends StatelessWidget {
    final String name;

    const HelloWorld({required this.name});

    @override
    Widget build(BuildContext context) {
        return Text('Hello $name from Flutter!');
    }
}