import 'package:favourite_places/providers/places_provider.dart';
import 'package:favourite_places/ui/screens/add_place.dart';
import 'package:favourite_places/ui/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends ConsumerState<PlacesScreen> {
  //late Future<List<Place>> _placesFuture;

  @override
  void initState() {
    super.initState();
    ref.read(placesProvider.notifier).getPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final placesList = ref.watch(placesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddPlaceScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: PlacesList(
        places: placesList,
      ),

/*       body: FutureBuilder(
        future: _placesFuture,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : PlaceList(
                    places: placesList,
                  ),
      ), */
    );
  }
}
