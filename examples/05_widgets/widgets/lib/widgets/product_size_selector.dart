import 'package:flutter/material.dart';
import 'package:widgets/models/product_size.dart';

class ProductSizeSelector extends StatelessWidget {
  final Set<ProductSize> selectedSizes;
  final ValueChanged<Set<ProductSize>> onSelectionChanged;

  // Constructor to accept selectedSizes and onSelected callback
  const ProductSizeSelector({
    required this.selectedSizes,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<ProductSize>(
      // Using .map to create ButtonSegments for each size
      segments: ProductSize.values.map((size) {
        return ButtonSegment<ProductSize>(
          value: size,
          label: Text(size.label),
        );
      }).toList(),
      selected: selectedSizes,
      multiSelectionEnabled: true, // Enable multi-selection
      onSelectionChanged: (Set<ProductSize> newSelection) {
        onSelectionChanged(newSelection);
      },
    );
  }
}
