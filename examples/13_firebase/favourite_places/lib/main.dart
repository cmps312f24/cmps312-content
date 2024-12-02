import 'package:favourite_places/ui/theme.dart';
import 'package:favourite_places/utils/conectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favourite_places/ui/screens/place.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const ProviderScope(
      child: PlacesApp(),
    ),
  );
}

class PlacesApp extends StatelessWidget {
  const PlacesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ConnectivityWrapper(
      child: MaterialApp(
        title: 'Great Places',
        theme: theme,
        debugShowCheckedModeBanner: false,
        home: const PlacesScreen(),
      ),
    );
  }
}
