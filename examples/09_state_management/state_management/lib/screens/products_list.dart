import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management/providers/categories_provider.dart';
import 'package:state_management/providers/products_provider.dart';
import 'package:state_management/providers/selected_category_provider.dart';
import 'package:state_management/widgets/product_tile.dart';

class ProductsScreen extends ConsumerWidget {
  const ProductsScreen();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final products = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Product List')),
      body: Column(
        children: [
          // Dropdown for category filter
          categories.when(
            data: (categories) {
              return DropdownMenu<String?>(
                initialSelection: selectedCategory,
                hintText: 'Select Category',
                dropdownMenuEntries: [
                  const DropdownMenuEntry(value: null, label: 'All'),
                  ...categories.map((category) => DropdownMenuEntry(
                        value: category,
                        label: category,
                      ))
                ],
                onSelected: (value) {
                  ref
                      .read(selectedCategoryProvider.notifier)
                      .setCategory(value);
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),

          // Product list
          Expanded(
            child: products.when(
              data: (products) {
                final filteredProducts = selectedCategory != null
                    ? products
                        .where((p) => p.category == selectedCategory)
                        .toList()
                    : products;
                return ListView.builder(
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    return ProductTile(
                      product: filteredProducts[index],
                      onTap: () {
                        // ToDo: Navigate to product detail screen
                      },
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }
}
