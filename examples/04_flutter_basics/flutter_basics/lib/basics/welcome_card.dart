import 'dart:math';
import 'package:flutter/material.dart';

class WelcomeCard extends StatefulWidget {
  final String name;

  const WelcomeCard({required this.name});

  @override
  _WelcomeCardState createState() => _WelcomeCardState();
}

class _WelcomeCardState extends State<WelcomeCard> {
  Color backgroundColor = Colors.white;
  int count = 0;

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/img_yahala.png',
            height: 200,
          ),
          const SizedBox(height: 16),
          Text("Welcome ${widget.name}!"),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                backgroundColor = getRandomColor();
                count += 1;
              });
            },
            child: Text("Change Color (clicked $count times)"),
          ),
        ],
      ),
    );
  }
}
