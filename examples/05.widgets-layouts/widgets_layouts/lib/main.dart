import 'package:flutter/material.dart';
import 'package:widgets_layouts/layout_demos/artist_card_screen.dart';
import 'package:widgets_layouts/layout_demos/responsive_screen.dart';
import 'package:widgets_layouts/screens/click_counter.dart';
import 'package:widgets_layouts/screens/counter_screen.dart';
import 'package:widgets_layouts/screens/lift_state_up.dart';
import 'package:widgets_layouts/screens/tip_calculator.dart';
import 'package:widgets_layouts/widget_demos/radio_button_screen.dart';
import 'package:widgets_layouts/widget_demos/button_screen.dart';
import 'package:widgets_layouts/widget_demos/check_box_screen.dart';
import 'package:widgets_layouts/widget_demos/dropdown_screen.dart';
import 'package:widgets_layouts/widget_demos/greeting.dart';
import 'package:widgets_layouts/widget_demos/slider_screen.dart';
import 'package:widgets_layouts/widget_demos/switch_screen.dart';
import 'package:widgets_layouts/widget_demos/text_field_screen.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Uncomment one of screens below to load it
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.lightGreen,
      ),
      home: //const Greeting(name: 'World'),
          //const GreetingApp(),
          //const ClickCounter(),
          //const CounterScreen(),
          //const ButtonScreen(),
          //const TextFieldScreen(),
          //CheckBoxScreen(),
          //const DropdownMenuScreen(),
          //const RadioButtonScreen(),
          //const SliderScreen(),
          //const SwitchScreen(),
          //const ArtistCardScreen(),
          //const ResponsiveScreen(),
          //const TipCalculator(),
          // State hoisting example
          const HelloScreen(),
    );
  }
}

class GreetingApp extends StatelessWidget {
  const GreetingApp();

  @override
  Widget build(BuildContext context) {
    //var theme = Theme.of(context);
    //var navigation = Navigator.of(context);
    //var media = MediaQuery.of(context);

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightGreen[50],
        appBar: AppBar(
          title: const Text('Greeting App'),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: const Center(
          child: Greeting(name: 'World'),
        ),
      ),
    );
  }
}
