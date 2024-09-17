// Define an enum for payment methods
enum PaymentMethod { creditCard, paypal, bankTransfer }

String processPayment(PaymentMethod payment, double amount) {
  // Switch expression with exhaustiveness checking
  /*
    All possible values of PaymentMethod are handled. 
    If a payment method is not handled, Dart compiler will require it 
    to be handled, ensuring exhaustive checking.
  */
  return switch (payment) {
    /*
      The case PaymentMethod.creditCard when amount > 1000 is a guard
      condition that checks if the amount is greater than 1000. 
      If true, it requires additional verification for larger payments.
    */
    PaymentMethod.creditCard when amount > 1000 =>
        'Credit card payment requires additional verification',
    PaymentMethod.creditCard =>
        'Processing payment of QR${amount} via Credit Card',
    PaymentMethod.paypal =>
        'Processing payment of QR${amount} via PayPal',
    PaymentMethod.bankTransfer =>
        'Processing payment of QR${amount} via Bank Transfer',
  };
}

void main() {
  // Test the function with different payment methods
  print(processPayment(PaymentMethod.creditCard, 1500)); 
  // Output: Credit card payment requires additional verification.

  print(processPayment(PaymentMethod.paypal, 500));     
  // Output: Processing payment of $500 via PayPal.
}
