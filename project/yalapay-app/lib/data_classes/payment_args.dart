import 'package:yalapay/models/payment.dart';

class PaymentArgs {
  final Payment? payment;
  final bool isAdd;
  final bool? isInvoice;
  final int? invoiceNo;


  PaymentArgs({this.payment, required this.isAdd, this.isInvoice, this.invoiceNo, required int invoiceId});
}