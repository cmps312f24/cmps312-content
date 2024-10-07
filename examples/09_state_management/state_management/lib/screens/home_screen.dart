import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Define a list of pages that correspond to the bottom navigation items
  static const _routes = ['/', '/counter', '/products', '/fruits', '/todo'];

  // Function to handle navigation on bottom nav item tap
  void _onTapNavItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pushNamed(context, _routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Riverpod Demo!'),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Weather (FutureProvider example)'),
              onPressed: () {
                Navigator.pushNamed(context, '/weather');
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Stock Price (FutureProvider example)'),
              onPressed: () {
                Navigator.pushNamed(context, '/stock');
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.yellow[50],
        currentIndex: _selectedIndex, // Highlight the selected tab
        onTap: _onTapNavItem,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Counter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_grocery_store),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apple),
            label: 'Fruits',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Todo',
          ),
        ],
      ),
    );
  }
}
