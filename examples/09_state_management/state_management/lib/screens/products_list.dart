import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management/providers/categories_provider.dart';
import 'package:state_management/providers/products_provider.dart';
import 'package:state_management/providers/selected_category_provider.dart';

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
          DropdownButton<String?>(
            value: selectedCategory,
            hint: const Text('Select Category'),
            items: [
              const DropdownMenuItem(value: null, child: Text('All')),
              ...categories.map((category) => DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  ))
            ],
            onChanged: (value) {
              ref.read(selectedCategoryProvider.notifier).setCategory(value);
            },
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
                    return ListTile(
                      title: Text(filteredProducts[index].name),
                      subtitle: Text(filteredProducts[index].category),
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
