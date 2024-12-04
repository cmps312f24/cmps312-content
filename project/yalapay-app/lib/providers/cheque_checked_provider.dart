import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChequeCheckedProvider extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}

final chequeCheckProviderNotifier = NotifierProvider<ChequeCheckedProvider, bool>(() => ChequeCheckedProvider());