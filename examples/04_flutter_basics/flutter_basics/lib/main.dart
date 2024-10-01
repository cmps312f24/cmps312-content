import 'package:flutter/material.dart';
import 'package:flutter_basics/widgets/click_counter.dart';
import 'package:flutter_basics/widgets/flutter_logo.dart';
import 'package:flutter_basics/widgets/greeting.dart';
import 'package:flutter_basics/widgets/hello_world.dart';
import 'package:flutter_basics/screens/welcome_screen.dart';

void main() {
  runApp(const MainApp());
  //runApp(const WelcomeScreen());
  //runApp(const FlutterLogoScreen());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: WelcomeScreen(),
          //child: ClicksCounter(),
          /* child: Column(
            children: [
              Greeting(name: 'Flutter'),
              SizedBox(height: 16),
              HelloWorld(name: 'CMPS 312 Team'),
              SizedBox(height: 16),
              ClicksCounter()
            ],
          ), */
        ),
      ),
    );
  }
}
