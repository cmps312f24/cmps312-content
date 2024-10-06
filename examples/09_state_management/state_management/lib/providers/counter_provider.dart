import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
  CounterNotifier class holds the counter state and 
  provides methods to increment and decrement the counter. 
  Listeners get notified whenever the state changes.
*/
class CounterNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void increment() => state++;

  void decrement() {
    if (state > 0) {
      state--;
    }
  }
}

/*
  NotifierProvider creates an instance of CounterNotifier, 
  allowing other widgets to listen for state changes.
*/
final counterProvider =
    NotifierProvider<CounterNotifier, int>(() => CounterNotifier());
