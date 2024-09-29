import 'package:flutter/material.dart';

class ClicksCounter extends StatefulWidget {
  const ClicksCounter();
  @override
  _ClicksCounterState createState() => _ClicksCounterState();
}

class _ClicksCounterState extends State<ClicksCounter> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Button pressed $_counter times'),
        ElevatedButton(
          onPressed: _incrementCounter,
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
