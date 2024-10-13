import 'package:flutter/material.dart';
import 'package:navigation/models/fruit.dart';
import 'package:navigation/screens/fruit_detail.dart';
import 'package:navigation/screens/fruits_list.dart';
import 'package:navigation/screens/home_screen.dart';
import 'package:navigation/screens/profile_screen.dart';
import 'package:navigation/screens/settings_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigator Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Define named routes
      routes: {
        '/': (context) => const HomeScreen(),
        'profile': (context) => const ProfileScreen(),
        'fruits': (context) => const FruitsScreen(),
        'settings': (context) => const SettingsScreen(),
        'fruitDetails': (context) {
          final fruit = ModalRoute.of(context)?.settings.arguments as Fruit;
          return FruitDetailScreen(fruit: fruit);
        },
      },
      initialRoute: '/',
    );
  }
}
