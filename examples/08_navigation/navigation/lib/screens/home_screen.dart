import 'package:flutter/material.dart';
import 'package:navigation/widgets/nav_bottom_bar.dart';
import 'package:navigation/widgets/nav_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Define a list of pages that correspond to the bottom navigation items
  static const _routes = ['/', 'fruits', 'profile', 'settings'];

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
      body: const Center(
        child: Text('Navigation Demo App!'),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTapNavItem: _onTapNavItem,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'fruits');
        },
        child: const Icon(Icons.local_grocery_store),
      ),
      drawer: const NavDrawer(),
      
    );
  }
}
