class ChequeDeposit {
  int id = 0;
  DateTime depositDate = DateTime.now();
  String bankAccountNo = '';
  String status = '';
  List<int> chequeNos = [];

  ChequeDeposit(this.id, this.depositDate, this.bankAccountNo, this.status, this.chequeNos);

  factory ChequeDeposit.fromJson(Map<String, dynamic> json) {
    return ChequeDeposit(
      int.parse(json['id']),
      DateTime.parse(json['depositDate']),
      json['bankAccountNo'],
      json['status'],
      json['chequeNos'].cast<int>(),
    );
  }

  bool containsText(String text) {
    final lowerText = text.toLowerCase();
    return id.toString().contains(text) ||
        depositDate.toString().contains(text) ||
        bankAccountNo.toLowerCase().contains(lowerText) ||
        status.toLowerCase().contains(lowerText) ||
        chequeNos.toString().contains(text);
  }
}