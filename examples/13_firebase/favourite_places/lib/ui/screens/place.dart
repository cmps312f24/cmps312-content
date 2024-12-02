import 'package:favourite_places/ui/widgets/main_drawer.dart';
import 'package:favourite_places/ui/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favourite_places/providers/places_provider.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() {
    return _PlacesScreenState();
  }
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  //late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();

    //_placesFuture = ref.read(placesProvider.notifier).getPlaces();
    ref.read(placesProvider.notifier).getPlaces();
  }

  void _navigateTo(String goTo) {
    Navigator.pop(context);
    if (goTo == 'Home') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const PlacesScreen(),
      ));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const PlacesScreen(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(placesProvider);
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
      body: PlacesList(
        places: userPlaces,
      ),
      /*body: FutureBuilder(
        future: _placesFuture,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : PlaceList(
                    places: userPlaces,
                  ),
      ),*/
    );
  }
}
