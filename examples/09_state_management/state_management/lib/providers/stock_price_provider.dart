import 'package:flutter_riverpod/flutter_riverpod.dart';

// .autoDispose is used to automatically dispose the
// provider when no longer needed (i.e., when the UI is no longer
// listening)
final stockPriceProvider = StreamProvider.autoDispose<double>((ref) async* {
  // Simulate fetching stock prices from an API.
  await Future.delayed(const Duration(seconds: 1));
  yield 150.0; // Initial price
  await Future.delayed(const Duration(seconds: 2));
  yield 152.5; // New price update
  await Future.delayed(const Duration(seconds: 2));
  yield 151.0; // Another update
});
