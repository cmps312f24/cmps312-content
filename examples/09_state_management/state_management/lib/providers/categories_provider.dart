import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management/repositories/product_repository.dart';

final categoriesProvider = FutureProvider<List<String>>((ref) async {
  return await ProductRepository.getCategories();
});
