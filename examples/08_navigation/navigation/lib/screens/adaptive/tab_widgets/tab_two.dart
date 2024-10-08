import 'package:flutter/material.dart';

class TabTwo extends StatelessWidget {
  const TabTwo();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text(
        "Hello from Tab 2",
        style: TextStyle(
            fontSize: 30.0, fontWeight: FontWeight.w900, color: Colors.cyan),
      ),
    );
  }
}
