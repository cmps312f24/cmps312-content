import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// StateNotifier to manage internet connectivity state
class ConnectivityNotifier extends StateNotifier<bool> {
  late final StreamSubscription _subscription;

  ConnectivityNotifier() : super(false) {
    _subscription = InternetConnection().onStatusChange.listen((event) {
      state = event == InternetStatus.connected;
    });
  }

  @override
  void dispose() {
    // Cancel subscription to avoid memory leaks
    _subscription.cancel();
    super.dispose();
  }
}

/// Provider for ConnectivityNotifier
final connectivityProvider =
    StateNotifierProvider<ConnectivityNotifier, bool>((ref) {
  return ConnectivityNotifier();
});
