import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalapay/models/payment.dart';
import 'package:yalapay/providers/cheque_provider.dart';
import 'package:yalapay/repositories/app_repository.dart';

class PaymentProvider extends Notifier<List<Payment>> {
  final AppRepository _appRepository = AppRepository();
  @override
  List<Payment> build() {
    initalizeState();
    return [];
  }

  void initalizeState() async {
    await _appRepository.initBanks(); 
    state = (await _appRepository.initPayments()).reversed.toList();
  }

  void searchPayments(String text) {
    final cheques = ref.read(chequeProviderNotifier);
    state = List.from(_appRepository.searchPayments(text, cheques).reversed);
  }

  void addPayment(Payment payment) {
    _appRepository.addPayment(payment);
    
    state = List.from(_appRepository.payments.reversed);
  }

  void deletePayment(Payment payment) {
    _appRepository.deletePayment(payment);
    state = List.from(_appRepository.payments.reversed);
  }

  void updatePayment(Payment payment) {
    _appRepository.updatePayment(payment);
    state = List.from(_appRepository.payments.reversed);
  }

  List<Payment> paymentState(int id) {
    return _appRepository.getPaymentsByInvoiceNo(id);
  }

  int getlastId() {
    return _appRepository.payments.last.id;
  }

  List<String> getBanks() {
    return _appRepository.banks;
  }

  void resetState() {
    state = List.from(_appRepository.payments.reversed);
  }

}

final paymentProviderNotifier = NotifierProvider<PaymentProvider, List<Payment>>(() => PaymentProvider());