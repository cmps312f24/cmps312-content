import 'package:flutter/material.dart';

enum ProductCategory {
  men('Men', Icons.male),
  women('Women', Icons.female),
  kids('Kids', Icons.child_care),
  all('All', Icons.category);

  final String label;
  final IconData icon;

  const ProductCategory(this.label, this.icon);
}
