import 'dart:isolate';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

// Example realistic long running computation
// Calculate the next probable prime based on a randomly generated BigInt
// which happens to be a fairly expensive task (since this calculation is based
// on a random it will not run in deterministic time)
BigInt nextProbablePrime() {
  // Just pretend to work hard for 3 seconds
  sleep(const Duration(seconds: 3));
  return BigInt.from(Random().nextInt(1000000));
}

// .autoDispose() is used to automatically dispose
//  the provider when no longer needed
class AsyncPrimeNotifier extends AsyncNotifier<BigInt> {
  @override
  Future<BigInt> build() async {
    return BigInt.from(0);
  }

  /*final primeProvider = FutureProvider.autoDispose<BigInt>((ref) async {
    return await getPrimeBigIntAsync();
  });

  final primeProviderInIsolate =
      FutureProvider.autoDispose<BigInt>((ref) async {
    return await getPrimeBigIntIsolate();
  }); */

  // Future version
  Future<void> getPrimeBigIntAsync() async {
    state = const AsyncValue.loading();
    //state = await AsyncValue.guard(() async {
    final prime = await Future.delayed(const Duration(seconds: 1), () {
      return nextProbablePrime();
    });
    state = AsyncValue.data(prime);
  }

  // Isolate version
  Future<void> getPrimeBigIntIsolate() async {
    state = const AsyncValue.loading();
    var prime = await Isolate.run(() => nextProbablePrime());
    state = AsyncValue.data(prime);
  }
}

final asyncPrimeProvider =
    AsyncNotifierProvider<AsyncPrimeNotifier, BigInt>(AsyncPrimeNotifier.new);

void sleep(Duration duration) {
  var ms = duration.inMilliseconds;
  var start = DateTime.now().millisecondsSinceEpoch;
  while (true) {
    var current = DateTime.now().millisecondsSinceEpoch;
    if (current - start >= ms) {
      break;
    }
  }
}
