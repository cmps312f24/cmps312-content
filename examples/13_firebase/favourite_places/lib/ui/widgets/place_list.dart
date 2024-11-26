import 'package:favourite_places/ui/widgets/place_item.dart';
import 'package:flutter/material.dart';

import 'package:favourite_places/models/place.dart';

class PlaceList extends StatelessWidget {
  const PlaceList({
    super.key,
    required this.places,
  });

  final List<Place> places;
  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Image.asset(
          'assets/images/no-data.png',
          width: 200,
        ),
      );
    }

    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        return PlaceItem(
          place: places[index],
        );
      },
    );
  }
}


// ListTile(
//           leading: CircleAvatar(
//             backgroundImage: FileImage(places[index].image),
//           ) ,
//           title: Text(
//             places[index].placeName,
//             style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                   color: Theme.of(context).colorScheme.onSurface,
//                 ),
//           ),
//           subtitle: Text(places[index].location.address, style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                   color: Theme.of(context).colorScheme.onSurface,
//                 ),
//           ),
//           onTap: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (ctx) => PlaceDetailScreen(
//                   place: places[index],
//                 ),
//               ),
//             );
//           },
//         );