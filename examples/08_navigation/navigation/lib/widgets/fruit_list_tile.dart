import 'package:flutter/material.dart';
import 'package:navigation/models/fruit.dart';

class FruitListTile extends StatelessWidget {
  final Fruit fruit;
  final VoidCallback onTap;

  const FruitListTile({
    required this.fruit,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image(
          image: AssetImage(fruit.imageUrl),
        ),
      ),
      title: Text(
        fruit.name,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(fruit.title),
      onTap: onTap,
    );
  }
}
