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

  The NotifierProvider<CounterNotifier, int> has two generic data types:
  - CounterNotifier (The Notifier class): specifies the type of 
    the Notifier class that will manage the state. 
    The Notifier is responsible for managing how the state is updated.
  - int (The type of state being managed): specifies the type of the 
  state being managed by the Notifier. 
  The state is what the UI listens to and rebuilds when it changes.
*/
final counterProvider =
    NotifierProvider<CounterNotifier, int>(() => CounterNotifier());
