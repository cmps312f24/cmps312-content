class Cheque {
  int chequeNo = 0;
  double amount = 0.0;
  String drawer = '';
  String bankName = '';
  String status = '';
  String chequeImageUri = '';
  String returnReason = '';
  DateTime receivedDate = DateTime.now();
  DateTime dueDate = DateTime.now();
  DateTime cashedDate = DateTime.now();

  Cheque(
  this.chequeNo, 
  this.amount, 
  this.drawer, 
  this.bankName, 
  this.status, 
  this.receivedDate, 
  this.dueDate, 
  this.chequeImageUri, 
  this.returnReason, 
  this.cashedDate
  );

 factory Cheque.fromJson(Map<String, dynamic> json) {
    return Cheque(
      json['chequeNo'],
      json['amount'],
      json['drawer'],
      json['bankName'],
      json['status'],
      DateTime.parse(json['receivedDate']),
      DateTime.parse(json['dueDate']),
      json['chequeImageUri'],
      '',
      DateTime.now()
    );
  }

  bool containsText(String text) {
    final lowerText = text.toLowerCase();
    return chequeNo.toString().contains(text) ||
        amount.toString().contains(text) ||
        drawer.toLowerCase().contains(lowerText) ||
        bankName.toLowerCase().contains(lowerText) ||
        status.toLowerCase().contains(lowerText) ||
        receivedDate.toString().contains(text) ||
        dueDate.toString().contains(text);
  }

  @override
  String toString() {
    return 'Cheque No: $chequeNo, Amount: $amount, Drawer: $drawer, Bank: $bankName, Status: $status, Received Date: $receivedDate, Due Date: $dueDate, Cheque Image: $chequeImageUri, Return Reason: $returnReason, Cashed Date: $cashedDate';
  }
}