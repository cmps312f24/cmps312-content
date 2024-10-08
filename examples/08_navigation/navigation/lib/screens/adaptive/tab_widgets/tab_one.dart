import 'package:flutter/material.dart';

class TabOne extends StatelessWidget {
  const TabOne();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text(
        "Hello from Tab 1",
        style: TextStyle(
            fontSize: 30.0, fontWeight: FontWeight.w900, color: Colors.indigo),
      ),
    );
  }
}
