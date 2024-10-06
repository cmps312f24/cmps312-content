import 'package:flutter/material.dart';

class ClicksCounter extends StatefulWidget {
  const ClicksCounter();
  // Creates the state object for the widget
  @override
  _ClicksCounterState createState() => _ClicksCounterState();
}

class _ClicksCounterState extends State<ClicksCounter> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _counter++;
        }); 
        //_counter++;
        print(_counter);
      },
      /*setState(() {
        _counter++;
      }), */
      child: Text('Button pressed $_counter times'),
    );
  }

  // Called after the widget is created for the first time
  // and inserted into the widget tree
  @override
  void initState() {
    super.initState();
    print('initState, mounted: $mounted');
  }

  // Called whenever the widget configuration changes
  // Triggered when the widget is rebuilt with updated properties.
  // It is called after build() and allows you to compare the previous
  // and current widget properties
  // might not be called during hot reload
  @override
  void didUpdateWidget(covariant ClicksCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget, mounted: $mounted');
  }

  @override
  void deactivate() {
    print('deactivate, mounted: $mounted');
    super.deactivate();
  }

  @override
  void dispose() {
    print('dispose, mounted: $mounted');
    super.dispose();
  }
}
