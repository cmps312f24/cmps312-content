import 'package:flutter/material.dart';
import 'package:flutter_basics/widgets/flutter_logo.dart';
import 'package:flutter_basics/widgets/greeting.dart';
import 'package:flutter_basics/widgets/hello_world.dart';
import 'package:flutter_basics/main_screen_with_nav.dart';
import 'package:flutter_basics/screens/clicks_counter_screen.dart';
import 'package:flutter_basics/screens/welcome_screen.dart';

void main2() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/greeting': (context) => const Greeting(name: 'Flutter'),
        '/hello': (context) => const HelloWorld(name: 'CMPS 312 Team'),
        '/welcome': (context) => const WelcomeScreen(),
        '/clicks-counter': (context) => const ClicksCounterScreen(),
        '/flutter-logo': (context) => const FlutterLogoScreen()
      },
    );
  }
}
