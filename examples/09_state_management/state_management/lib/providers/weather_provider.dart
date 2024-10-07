import 'package:flutter_riverpod/flutter_riverpod.dart';

// .autoDispose() is used to automatically dispose
//  the provider when no longer needed
final weatherProvider = FutureProvider.autoDispose<String>((ref) async {
  // Simulate network call
  await Future.delayed(const Duration(seconds: 2));
  return "Sunny"; // Data returned from API
});
