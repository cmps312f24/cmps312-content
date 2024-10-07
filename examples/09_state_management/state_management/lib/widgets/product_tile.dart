import 'package:flutter/material.dart';
import 'package:state_management/models/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductTile({
    required this.product,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '${product.name} (\$${product.price})',
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(product.description),
      onTap: onTap,
    );
  }
}
