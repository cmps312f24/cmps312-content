import 'package:flutter/material.dart';
import 'package:widgets/models/product_category.dart';

// Define the enum class with a label property
class ProductCategorySelector extends StatelessWidget {
  final ProductCategory initialCategory;
  final ValueChanged<ProductCategory> onSelectionChanged;

  // Constructor to accept selectedCategory and onSelected callback
  const ProductCategorySelector({
    required this.initialCategory,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<ProductCategory>(
      segments: ProductCategory.values.map((ProductCategory category) {
        return ButtonSegment<ProductCategory>(
          value: category,
          label: Text(category.label),
          icon: Icon(category.icon),
        );
      }).toList(),
      selected: {initialCategory},
      onSelectionChanged: (newSelection) {
        onSelectionChanged(newSelection.first);
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Product Category Selector Example')),
      body: Center(
        child: ProductCategorySelector(
          initialCategory: ProductCategory.all,
          onSelectionChanged: (category) {
            // Handle the category selection event
            print('Selected category: ${category.label}');
          },
        ),
      ),
    ),
  ));
}
