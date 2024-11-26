import 'package:favourite_places/ui/screens/manage.dart';
import 'package:favourite_places/ui/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favourite_places/providers/user_places.dart';
import 'package:favourite_places/ui/widgets/place_list.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() {
    return _PlacesScreenState();
  }
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();

    _placesFuture = ref.read(userPlacesProvider.notifier).getPlaces();
  }

  void _navigateTo(String goTo) {
    Navigator.pop(context);
    if (goTo == 'Home') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const PlacesScreen(),
      ));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const ManageScreen(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(userPlacesProvider);
    return Scaffold(
      drawer: MainDrawer(
        onPressedNavigate: _navigateTo,
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          'Your Places',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      body: FutureBuilder(
        future: _placesFuture,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : PlaceList(
                    places: userPlaces,
                  ),
      ),
    );
  }
}
