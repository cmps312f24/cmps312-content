import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen();

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State {
  var selectedItem = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter UI Examples"),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(onSelected: (value) {
            setState(() {
              selectedItem = value.toString();
            });
            Navigator.pushNamed(context, value.toString());
          }, itemBuilder: (BuildContext bc) {
            return const [
              PopupMenuItem<String>(
                value: '/greeting',
                child: Text("Greeting"),
              ),
              PopupMenuItem<String>(
                value: '/hello',
                child: Text("Hello"),
              ),
              PopupMenuItem<String>(
                value: '/welcome',
                child: Text("Welcome"),
              ),
              PopupMenuItem<String>(
                value: '/welcome',
                child: Text("Welcome"),
              ),
              PopupMenuItem<String>(
                value: '/flutter-logo',
                child: Text("Flutter Logo"),
              ),
              PopupMenuDivider(),
              PopupMenuItem<String>(
                value: '/clicks-counter',
                child: Text("Clicks Counter"),
              ),
            ];
          })
        ],
      ),
      body: Center(
        child: Text(selectedItem),
      ),
    );
  }
}
