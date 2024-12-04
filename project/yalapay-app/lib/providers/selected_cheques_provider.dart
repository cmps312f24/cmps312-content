import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalapay/models/cheque.dart';

class SelectedChequesProvider extends Notifier<List<Cheque>> {
  @override
  List<Cheque> build() {
    return [];
  }
}

final selectedChequeProviderNotifier = NotifierProvider<SelectedChequesProvider, List<Cheque>>(() => SelectedChequesProvider());