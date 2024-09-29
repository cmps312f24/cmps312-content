import 'package:flutter/material.dart';
import 'package:flutter_basics/basics/click_counter.dart';
import 'package:flutter_basics/basics/greeting.dart';
import 'package:flutter_basics/basics/hello_world.dart';
import 'package:flutter_basics/state/welcome_screen.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Basics'),
        ),
        //bottomNavigationBar: const WelcomeScreen(),
        body: const Center(
          child: Greeting(name: 'Flutter'),
        ),
      ),
    ),
  );
/*   //runApp(const MainApp());
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Basics'),
      ),
      //bottomNavigationBar: ,
      body: Center(
        child: Greeting(name: 'Flutter'),
      ),
    ),
  )); */
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          //child: WelcomeScreen(),
          child: Column(
            children: [
              Greeting(name: 'Flutter'),
              HelloWorld(name: 'CMPS 312 Team'),
              ClicksCounter(),
              //WelcomeScreen(),
            ],
          ),
          //WelcomeScreen(),
          //Text('Hello World!'),
        ),
      ),
    );
  }
}
