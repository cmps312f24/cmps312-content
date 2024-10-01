import 'package:flutter/material.dart';

class FlutterLogoScreen extends StatelessWidget {
  const FlutterLogoScreen();

  @override
  Widget build(BuildContext context) {
    //widget tree starts here
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(3),
            child: const FlutterLogo(
              size: 10,
            ), //FlutterLogo
          ), //Container
          title: const Text('Welcome to Flutter!'),
          elevation: 10,
          centerTitle: true,
        ), //AppBar
        body: const Center(
          child: FlutterLogo(
            size: 100,
            duration: Duration(seconds: 5),
            curve: Curves.easeIn,
            textColor: Colors.lightBlueAccent,
            style: FlutterLogoStyle.stacked,
          ), //Container
        ), //Center
      ), //Scaffold
    );
  }
}
