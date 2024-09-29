import 'package:flutter/material.dart';

class ResponsiveScreen extends StatelessWidget {
    const ResponsiveScreen();
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Container(
                color: const Color(0xFFEDEAE0),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                                width: double.infinity,
                                color: const Color(0xFF8DB600),
                                child: const Center(
                                    child: Text("Height: 1F -> 1/10 of space"),
                                ),
                            ),
                        ),
                        Expanded(
                            flex: 8,
                            child: Row(
                                children: [
                                    Expanded(
                                        flex: 3,
                                        child: Container(
                                            color: Colors.cyan,
                                            child: const Center(
                                                child: Text(
                                                    "Height: 8F -> 8/10 of space\nWidth: 3F -> 3/4 of space",
                                                    textAlign: TextAlign.center,
                                                ),
                                            ),
                                        ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            color: Colors.yellow,
                                            child: const Center(
                                                child: Text(
                                                    "Height: 8F -> 8/10 of space\nWidth: 1F -> 1/4 of space",
                                                    textAlign: TextAlign.center,
                                                ),
                                            ),
                                        ),
                                    ),
                                ],
                            ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                                width: double.infinity,
                                color: Colors.grey[300],
                                child: const Center(
                                    child: Text("Height: 1F -> 1/10 of space"),
                                ),
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}