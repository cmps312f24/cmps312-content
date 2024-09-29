import 'package:flutter/material.dart';

class ClicksCounterScreen extends StatefulWidget {
    const ClicksCounterScreen();
    @override
    _ClicksCounterScreenState createState() => _ClicksCounterScreenState();
}

class _ClicksCounterScreenState extends State<ClicksCounterScreen> {
    int clickCount = 0;

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Clicks Counter'),
            ),
            body: Column(
                children: [
                    ClickCounter(
                        clicks: clickCount,
                        onClick: () {
                            setState(() {
                                clickCount++;
                            });
                        },
                    ),
                    Text('Counter $clickCount'),
                ],
            ),
        );
    }
}

class ClickCounter extends StatelessWidget {
    final int clicks;
    final VoidCallback onClick;

    ClickCounter({required this.clicks, required this.onClick});

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: onClick,
                child: Text("I've been clicked $clicks times"),
            ),
        );
    }
}