import 'package:flutter_riverpod/flutter_riverpod.dart';

final weatherProvider = FutureProvider<String>((ref) async {
  // Simulate network call
  await Future.delayed(const Duration(seconds: 2)); 
  return "Sunny";  // Data returned from API
});