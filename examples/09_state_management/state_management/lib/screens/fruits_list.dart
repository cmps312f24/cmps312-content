import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management/providers/fruits_provider.dart';
import 'package:state_management/screens/fruit_detail.dart';
import 'package:state_management/widgets/fruit_tile.dart';

class FruitsScreen extends ConsumerWidget {
  const FruitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var fruits = ref.watch(fruitsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruits List'),
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        itemCount: fruits.length,
        itemBuilder: (context, index) {
          final fruit = fruits[index];
          return FruitTile(
            fruit: fruit,
            onTap: () {
              /* Navigator.of(context).pushNamed(
                '/fruitDetails',
                arguments: fruit,
              ); */

              // Keeps popping until it finds the route named '/home'
              /* Navigator.of(context).popUntil(
                ModalRoute.withName('/home'),
              ); */

              /*Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => DashboardScreen()),
                // Keep popping until the '/home' route, but leave it in the stack
                ModalRoute.withName('/home'), 
              );*/

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return FruitDetailScreen(fruit: fruit);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
