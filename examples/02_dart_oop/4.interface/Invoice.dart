import 'Payable.dart';

class Invoice implements Payable {
  final DateTime invoiceDate;
  final double totalAmount;

  Invoice(this.invoiceDate, this.totalAmount);

  @override
  double get amount => totalAmount;

  @override
  String pay() => "Pay by Credit Card invoice issued on $invoiceDate of $amount";
}
