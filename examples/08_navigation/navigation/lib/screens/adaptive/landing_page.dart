import 'package:flutter/material.dart';
import 'package:navigation/screens/adaptive/config/tab_config.dart';
import 'package:navigation/screens/adaptive/tab_views/tab_one.dart';
import 'package:navigation/screens/adaptive/tab_views/tab_three.dart';
import 'package:navigation/screens/adaptive/tab_views/tab_two.dart';

class LandingPage extends StatefulWidget {
  const LandingPage();
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SafeArea(
            bottom: false,
            child: constraints.maxWidth > 600
                ? Row(
                    children: <Widget>[
                      NavigationRail(
                          labelType: NavigationRailLabelType.all,
                          onDestinationSelected: (value) => _changePage(value),
                          selectedIconTheme:
                              const IconThemeData(color: Colors.red),
                          unselectedIconTheme:
                              const IconThemeData(color: Colors.black),
                          destinations: List.generate(
                            tabData.length,
                            (index) => NavigationRailDestination(
                              icon: Icon(tabData[index]["icon"] as IconData?),
                              label: Text(tabData[index]["label"] as String),
                            ),
                          ),
                          selectedIndex: _selectedIndex),
                      Expanded(child: _renderChild(_selectedIndex)),
                    ],
                  )
                : Column(
                    children: <Widget>[
                      Expanded(child: _renderChild(_selectedIndex)),
                      BottomNavigationBar(
                          currentIndex: _selectedIndex,
                          selectedIconTheme:
                              const IconThemeData(color: Colors.red),
                          onTap: (value) => _changePage(value),
                          items: List.generate(
                            tabData.length,
                            (index) => BottomNavigationBarItem(
                              icon: Icon(tabData[index]["icon"] as IconData?),
                              label: tabData[index]["label"] as String,
                            ),
                          ))
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _renderChild(index) {
    switch (index) {
      case 0:
        return const TabOne();
      case 1:
        return const TabTwo();
      case 2:
        return const TabThree();
      default:
        return Container(
          child: const Text("Something feels fishy! :P"),
        );
    }
  }

  _changePage(index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
