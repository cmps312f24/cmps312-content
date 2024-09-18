void main() {
  // A list of records representing transactions with named fields
  var transactions = [
    (date: '01-09-2024', type: 'DEPOSIT', amount: 2250.00),
    (date: '05-09-2024', type: 'WITHDRAWAL', amount: 255.73),
    (date: '15-09-2024', type: 'DIVIDEND', amount: 1.65),
    (date: '18-09-2024', type: 'FEE', amount: 5.50)
  ];

  double balance = 0.0;

  for (var transaction in transactions) {
    switch (transaction) {
      case (date: _, type: 'DEPOSIT', amount: var amount):
        balance += amount;
        print('Deposit of \$${amount}, New Balance: \$${balance}');
        break;

      case (date: _, type: 'WITHDRAWAL', amount: var amount):
        balance -= amount;
        print('Withdrawal of \$${amount}, New Balance: \$${balance}');
        break;

      case (date: _, type: 'DIVIDEND', amount: var amount):
        balance += amount;
        print('Dividend of \$${amount}, New Balance: \$${balance}');
        break;

      case (date: _, type: 'FEE', amount: var fee):
        balance -= fee;
        print('Fee of \$${fee}, New Balance: \$${balance}');
        break;

      default:
        print('Unknown transaction type.');
    }
  }
}
