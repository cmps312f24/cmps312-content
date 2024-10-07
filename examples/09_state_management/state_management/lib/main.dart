import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management/screens/api_url_screen.dart';
import 'package:state_management/screens/counter_screen.dart';
import 'package:state_management/screens/fruits_list.dart';
import 'package:state_management/screens/home_screen.dart';
import 'package:state_management/screens/products_list.dart';
import 'package:state_management/screens/stock_price_screen.dart';
import 'package:state_management/screens/todo_list.dart';
import 'package:state_management/screens/weather_screen.dart';

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
          '/counter': (context) => const CounterScreen(),
          '/products': (context) => const ProductsScreen(),
          '/fruits': (context) => const FruitsScreen(),
          '/todo': (context) => const TodoListScreen(),
          '/weather': (context) => const WeatherScreen(),
          '/stock': (context) => const StockPriceScreen(),
          '/api_url': (context) => const ApiUrlScreen(),
        },
        initialRoute: '/',
      ),
    );
  }
}
