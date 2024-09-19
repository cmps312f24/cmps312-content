sealed class PaymentMethod {}

class CreditCard extends PaymentMethod {
  final String cardNumber;
  CreditCard(this.cardNumber);
}

class PayPal extends PaymentMethod {
  final String email;
  PayPal(this.email);
}

class BankTransfer extends PaymentMethod {
  final String bankAccount;
  BankTransfer(this.bankAccount);
}

/*
  Exhaustive Pattern Matching: ensures that all possible payment types 
  are handled in the switch expression.
  - Dart compiler knows that PaymentMethod has exactly three possible types:
   CreditCard, PayPal, and BankTransfer because it’s a sealed class. 
   This allows the switch expression to be exhaustive.
  - sealed class that can only be extended by classes defined 
    in the same library.
  - This guarantees that no case is left unhandled, making the code 
    more reliable.
  - In the switch we use a pattern to extract the relevant field 
    (cardNumber, email, or bankAccount) and process the payment accordingly.
*/
String processPayment(PaymentMethod paymentMethod) {
  // If you comment any of the below lines,
  // you will get a compile-time error
  return switch (paymentMethod) {
    CreditCard(:var cardNumber) =>
      'Processing credit card payment with card number: $cardNumber',
    PayPal(:var email) => 'Processing PayPal payment with email: $email',
    BankTransfer(:var bankAccount) =>
      'Processing bank transfer to account: $bankAccount',
  };
}

void main() {
  final creditCard = CreditCard('1234 5678 9012 3456');
  final payPal = PayPal('pay@dart.dev');
  final bankTransfer = BankTransfer('122448');
  final payables = [creditCard, payPal, bankTransfer];
  payables.forEach((paymentMethod) => print(processPayment(paymentMethod)));
}
