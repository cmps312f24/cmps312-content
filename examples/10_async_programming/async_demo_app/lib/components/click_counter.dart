import 'package:flutter/material.dart';

class ClickCounter extends StatefulWidget {
  const ClickCounter() : super();
  @override
  _ClickCounterState createState() => _ClickCounterState();
}

class _ClickCounterState extends State<ClickCounter> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _incrementCounter,
      child: Text('Clicks: $_counter'),
    );
  }
}
