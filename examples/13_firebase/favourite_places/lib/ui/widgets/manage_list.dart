import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/ui/widgets/manage_item.dart';
import 'package:flutter/material.dart';

class ManageList extends StatelessWidget {
  const ManageList({super.key, required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Image.asset('assets/images/no-data.png'),
      );
    }

    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        return ManageItem(
          place: places[index],
        );
      },
    );
  }
}
