class Payment {
  int id = 0;
  int invoiceNo = 0;
  double amount = 0.0;
  DateTime paymentDate = DateTime.now();
  String paymentMode = '';
  int chequeNo = 0;

  Payment(this.id, this.invoiceNo, this.amount, this.paymentDate, this.paymentMode, this.chequeNo);

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      int.parse(json['id']),
      int.parse(json['invoiceNo']),
      json['amount'],
      DateTime.parse(json['paymentDate']),
      json['paymentMode'],
      json['chequeNo']??0,
    );
  }

  bool containsText(String text) {
    return id.toString().contains(text) ||
        invoiceNo.toString().contains(text) ||
        amount.toString().contains(text) ||
        paymentDate.toString().contains(text) ||
        paymentMode.toLowerCase().contains(text) ||
        chequeNo.toString().contains(text);
  }

  @override
  String toString() {
    return 'Payment{id: $id, invoiceNo: $invoiceNo, amount: $amount, paymentDate: $paymentDate, paymentMode: $paymentMode, chequeNo: $chequeNo}';
  }
}