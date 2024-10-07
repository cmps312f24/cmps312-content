// Products data source (using FutureProvider to simulate API fetch)
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management/models/product.dart';
import 'package:state_management/repositories/product_repository.dart';

final productsProvider = FutureProvider<List<Product>>((ref) async {
  await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
  return ProductRepository.getProducts();
});
