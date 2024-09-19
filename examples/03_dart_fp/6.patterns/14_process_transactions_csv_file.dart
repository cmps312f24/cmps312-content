import 'dart:io';

double getBalance(List<String> transactions) {
  var balance = 0.0;
  for (var t in transactions) {
    var trans = t.split(",").map((e) => e.trim()).toList();
    print(trans);
    balance += switch (trans) {
      [_, "DEPOSIT", _, var amount] => double.parse(amount),
      [_, "WITHDRAWAL", _, var amount] => double.parse(amount) * -1,
      [_, "DIVIDEND", _, var amount] => double.parse(amount),
      [_, "FEE", _, var fee] => double.parse(fee) * -1,
      _ => throw new FormatException('Invalid transaction type'),
    };
  }
  return balance;
}

void main(List<String> args) {
  // Read the transactions from a CSV file
  try {
  var transFileContent = File('./data/bank_trans.txt').readAsStringSync();
  var transactions = transFileContent.split('\n').toList();
  var balance = getBalance(transactions);
  print('Balance: \$${balance}');
  }
  catch (e) {
    print('Error: $e');
  } 
}
