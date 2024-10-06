import '../models/fruit.dart';
import 'package:flutter/material.dart';

class FruitDetailScreen extends StatelessWidget {
  final Fruit fruit;

  const FruitDetailScreen({required this.fruit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fruit.name),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: AssetImage(fruit.imageUrl),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                fruit.description,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
