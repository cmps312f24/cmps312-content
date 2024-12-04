class BankAccount {
  String accountNumber = '';
  String bank = '';

  BankAccount(this.accountNumber, this.bank);

  factory BankAccount.fromJson(Map<String, dynamic> json) {
    return BankAccount(
      json['accountNo'],
      json['bank'],
    );
  }

  @override
  String toString() {
    return '$bank: $accountNumber';
  }
}