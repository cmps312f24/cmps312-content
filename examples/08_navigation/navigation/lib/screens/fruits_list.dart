import 'package:flutter/material.dart';
import 'package:navigation/repositories/fruit_repository.dart';
import 'package:navigation/widgets/fruit_list_tile.dart';

class FruitsScreen extends StatelessWidget {
  const FruitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var fruits = FruitRepository.getFruits();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruits List'),
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        itemCount: fruits.length,
        itemBuilder: (context, index) {
          final fruit = fruits[index];
          return FruitListTile(
            fruit: fruit,
            onTap: () {
              Navigator.of(context).pushNamed('fruitDetails', arguments: fruit);
              /*Navigator.of(context).push(
                //FruitDetailScreen(fruit: fruit)
                MaterialPageRoute(
                  builder: (context) {
                    return FruitDetailScreen(fruit: fruit);
                  },
                ),
              );*/
            },
          );
        },
      ),
    );
  }
}
