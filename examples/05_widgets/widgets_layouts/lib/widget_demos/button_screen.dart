// ignore: file_names
import 'package:flutter/material.dart';

class ButtonScreen extends StatefulWidget {
  const ButtonScreen({super.key});
  @override
  _ButtonScreenState createState() => _ButtonScreenState();
}

class _ButtonScreenState extends State<ButtonScreen> {
  String message = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  message = "Button clicked";
                });
              },
              child: const Text("Button"),
            ),
            const SizedBox(height: 5),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  message = "OutlinedButton clicked";
                });
              },
              child: const Text("OutlinedButton"),
            ),
            const SizedBox(height: 5),
            TextButton(
              onPressed: () {
                setState(() {
                  message = "TextButton clicked";
                });
              },
              child: const Text("TextButton"),
            ),
            const SizedBox(height: 5),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() {
                  message = "Search IconButton clicked";
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
