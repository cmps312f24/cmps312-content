class Invoice {
  int id = 0;
  int customerId = 0;
  String customerName = '';
  double amount = 0.0;
  DateTime invoiceDate = DateTime.now();
  DateTime dueDate = DateTime.now();
  

  Invoice(this.id, this.customerId, this.customerName, this.amount, this.invoiceDate, this.dueDate);

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      int.parse(json['id']),
      int.parse(json['customerId']),
      json['customerName'],
      json['amount'],
      DateTime.parse(json['invoiceDate']),
      DateTime.parse(json['dueDate']),
    );
  }

  bool containsText(String text) {
    return id.toString().contains(text) ||
        customerId.toString().contains(text) ||
        customerName.toLowerCase().contains(text) ||
        amount.toString().contains(text) ||
        invoiceDate.toString().contains(text) ||
        dueDate.toString().contains(text);
  }

  @override
  String toString() {
    return 'Invoice{id: $id, customerId: $customerId, customerName: $customerName, amount: $amount, invoiceDate: $invoiceDate, dueDate: $dueDate}';
  }
}