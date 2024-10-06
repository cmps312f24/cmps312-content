import 'package:flutter_riverpod/flutter_riverpod.dart';

// List of categories (using Provider)
final categoriesProvider = Provider<List<String>>((ref) {
  return ['Electronics', 'Clothing', 'Books'];
});
