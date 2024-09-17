double getBalance(List<String> trans) {
  var balance = 0.0;
  for (var tran in trans) {
    var transInfo = tran.split(",").map((e) => e.trim()).toList();
    balance += switch (transInfo) {
      [_, "DEPOSIT", _, var amount] => amount as double,
      [_, "WITHDRAWAL", _, var amount] => (amount as double) * -1,
      [_, "INTEREST", var amount] => amount as double,
      [_, "FEE", var fee] => (fee as double) * -1,
      _ => throw new FormatException('Invalid transaction type'),
    };
  }
  return balance;
}
