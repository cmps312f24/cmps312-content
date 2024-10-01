import 'package:flutter/material.dart';
import 'package:widgets/models/product_category.dart';
import 'package:widgets/models/product_size.dart';
import 'package:widgets/models/weather.dart';
import 'package:widgets/widgets/product_category_selector.dart';
import 'package:widgets/widgets/product_size_selector.dart';
import 'package:widgets/widgets/weather_selector.dart';

class SegmentedButtonScreen extends StatefulWidget {
  const SegmentedButtonScreen();
  @override
  _SegmentedButtonScreenState createState() => _SegmentedButtonScreenState();
}

class _SegmentedButtonScreenState extends State<SegmentedButtonScreen> {
  // State variable to hold the selected category
  ProductCategory selectedCategory = ProductCategory.all;
  Set<ProductSize> selectedSizes = {ProductSize.medium}; // Default selection
  Weather selectedWeather = Weather.rainy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Segmented Button Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProductCategorySelector(
              initialCategory: selectedCategory,
              onSelectionChanged: (category) {
                // Update the state when a new category is selected
                setState(() {
                  selectedCategory = category;
                });
              },
            ),

            const SizedBox(height: 20),
            // Display the selected category
            Text('Selected Category: ${selectedCategory.label}'),
            const SizedBox(height: 20),

            // Use the ProductSizeSelector to allow multiple size selection
            ProductSizeSelector(
              selectedSizes: selectedSizes,
              onSelectionChanged: (sizes) {
                // Update the state when a new size selection is made
                setState(() {
                  selectedSizes = sizes;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
                'Selected Sizes: ${selectedSizes.map((size) => size.label).join(', ')}'),

            const SizedBox(height: 20),
            WeatherSelector(
              selectedWeather: selectedWeather,
              onSelectionChanged: (newSelection) {
                setState(() {
                  selectedWeather = newSelection;
                });
              },
            ),
            const SizedBox(height: 20),
            Text('Selected weather: ${selectedWeather.label}'),
          ],
        ),
      ),
    );
  }
}