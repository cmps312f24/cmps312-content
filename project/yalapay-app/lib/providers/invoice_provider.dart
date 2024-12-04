import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalapay/models/invoice.dart';
import 'package:yalapay/providers/cheque_provider.dart';
import 'package:yalapay/providers/payment_provider.dart';
import 'package:yalapay/repositories/app_repository.dart';

class InvoiceProvider extends Notifier<List<Invoice>> {
  final AppRepository _appRepository = AppRepository();

  @override
  List<Invoice> build() {
    initalizeState();
    return [];
  }

  void initalizeState() async {
    state = (await _appRepository.initInvoices()).reversed.toList();
  }

  Invoice getInvoiceById(int id) {
    return _appRepository.getInvoiceById(id);
  }

  void searchInvoices(String text) {
    final watchPayment = ref.watch(paymentProviderNotifier);
    final watchCheque = ref.watch(chequeProviderNotifier);
    state = List.from(_appRepository.searchInvoices(text, watchPayment, watchCheque).reversed);
  }

  void addInvoice(Invoice invoice) {
    _appRepository.addInvoice(invoice);
    state = List.from(_appRepository.invoices.reversed);
  }

  void deleteInvoice(Invoice invoice) {
    _appRepository.deleteInvoice(invoice);
    state = List.from(_appRepository.invoices.reversed);
  }
  
  int getlastId() {
    return _appRepository.invoices.last.id;
  }

  void updateInvoice(Invoice invoice) {
    _appRepository.updateInvoice(invoice);
    state = List.from(_appRepository.invoices.reversed);
  }

  void getByInvoiceDate(DateTime fromDate, DateTime toDate) {
    state = _appRepository.getByInvoiceDate(fromDate, toDate).reversed.toList();
  }

  (List<Invoice> invoices, int count, double amount) filterInvoices(DateTime fromDate, DateTime toDate, String status) {  
  var invoices = _appRepository.invoices;
  var payments = ref.read(paymentProviderNotifier);

  List<Invoice> all = invoices.where((element) => element.invoiceDate.isAfter(fromDate) && element.invoiceDate.isBefore(toDate)).toList();
  List<Invoice> paid = [];
  List<Invoice> partiallyPaid = [];
  List<Invoice> pending = [];

  double paidTotal = 0;
  double partiallyPaidTotal = 0;
  double pendingTotal = 0;

  for (var i in invoices) {
    double amount = 0;
    if(i.invoiceDate.isBefore(toDate) && i.invoiceDate.isAfter(fromDate)) {
        for (var p in payments) {
        if (i.id == p.invoiceNo) {
          if (p.paymentMode.toLowerCase() == "cheque") {
            var cheque = ref.read(chequeProviderNotifier.notifier).getChequeById(p.chequeNo);
            if (cheque.status.toLowerCase() == "cashed") {
              amount += cheque.amount;
            }
          } else {
            amount += p.amount;
          }
        }
      }

      if (amount == i.amount) {
        paid.add(i);
        paidTotal += amount;
      } else if (amount > 0 && amount < i.amount) {
        partiallyPaid.add(i);
        partiallyPaidTotal += amount;
      } else {
        pending.add(i);
        pendingTotal += i.amount;
      }
    }   
  }
  
  if (status.toLowerCase() == "paid") {
    return (paid, paid.length, paidTotal);
  } else if (status.toLowerCase() == "partially paid") {
    return (partiallyPaid, partiallyPaid.length, partiallyPaidTotal);
  } else if (status.toLowerCase() == "pending") {
    return (pending, pending.length, pendingTotal);
  } else {
    if(all.isEmpty) {
      return (all, all.length, 0);
    }
    return (all, all.length, paidTotal + partiallyPaidTotal + pendingTotal);
  }
}

void resetState() {
  state = _appRepository.invoices.reversed.toList();
}


}

final invoiceProviderNotifier = NotifierProvider<InvoiceProvider, List<Invoice>>(() => InvoiceProvider());