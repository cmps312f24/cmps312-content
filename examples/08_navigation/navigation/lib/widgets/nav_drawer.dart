import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Navigation Demo App'),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            title: const Text('Fruits'),
            onTap: () {
              Navigator.pushNamed(context, 'fruits');
            },
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, 'profile');
            },
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              Navigator.pushNamed(context, 'settings');
            },
          ),
        ],
      ),
    );
  }
}
