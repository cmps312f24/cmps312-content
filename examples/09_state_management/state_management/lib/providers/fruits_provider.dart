import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management/models/fruit.dart';
import 'package:state_management/repositories/fruit_repository.dart';

// List of categories (using Provider)
final fruitsProvider = Provider<List<Fruit>>((ref) {
  return FruitRepository.getFruits();
});
