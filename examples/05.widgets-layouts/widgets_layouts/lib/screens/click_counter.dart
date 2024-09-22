import 'package:flutter/material.dart';

class ClickCounter extends StatefulWidget {
  const ClickCounter();
  @override
  _ClickCounterState createState() => _ClickCounterState();
}

class _ClickCounterState extends State<ClickCounter> {
  int clicksCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Click Counter'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              clicksCount += 1;
            });
          },
          child: Text("I've been clicked $clicksCount times"),
        ),
      ),
    );
  }
}
