import 'package:flutter/material.dart';

class TabThree extends StatelessWidget {
  const TabThree();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text(
        "Hello from Tab 3",
        style: TextStyle(
            fontSize: 30.0, fontWeight: FontWeight.w900, color: Colors.blue),
      ),
    );
  }
}
