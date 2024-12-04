import 'package:yalapay/models/invoice.dart';

class InvoiceArgs {
  final Invoice? invoice;
  final bool isAdd;

  InvoiceArgs({this.invoice, this.isAdd = false});
}