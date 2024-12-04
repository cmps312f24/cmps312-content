import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalapay/models/cheque.dart';

class UpdatedChequesProvider extends Notifier<List<Cheque>> {
  @override
  List<Cheque> build() {
    return [];
  }

  void addCheque(Cheque cheque) {
    state = [...state, cheque];
  }

  void updateChequeStatusAndCashedDate(Cheque cheque, String status, DateTime cashedDate, String returnReason) {
    state = state.map((element) {
      if (element.chequeNo == cheque.chequeNo) {
        return Cheque(
          element.chequeNo,
          element.amount,
          element.drawer,
          element.bankName,
          status,
          element.receivedDate,
          element.dueDate,
          element.chequeImageUri,
          returnReason,
          cashedDate, 
        );
      }
      return element;
    }).toList();
  }

  bool chequeExists(Cheque cheque) {
    return state.any((element) => element.chequeNo == cheque.chequeNo);
  }
}
final updatedChequesProviderNotifier = NotifierProvider<UpdatedChequesProvider, List<Cheque>>(() => UpdatedChequesProvider());