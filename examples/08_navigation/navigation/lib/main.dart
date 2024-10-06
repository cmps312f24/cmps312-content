import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation/models/counter_provider.dart';
import 'package:navigation/screens/counter_screen.dart';
import 'package:navigation/screens/fruits_list.dart';
import 'package:navigation/screens/home_screen.dart';
import 'package:navigation/screens/products_list.dart';
import 'package:navigation/screens/profile_screen.dart';
import 'package:navigation/screens/settings_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Navigator Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //home: const FruitListScreen(),
        // Define named routes
        routes: {
          '/': (context) => const HomeScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/fruits': (context) => const FruitsScreen(),
          '/settings': (context) => const SettingsScreen(),
        },
        initialRoute: '/',
      ),
    );
  }
}
