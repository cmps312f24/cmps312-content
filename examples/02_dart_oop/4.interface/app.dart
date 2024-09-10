import 'Employee.dart';
import 'Invoice.dart';

void main() {
  // List of payable objects
  var payables = [
    Employee("Ali", "Faleh", 3000),
    Employee("Sara", "Saleh", 5000),
    Invoice(DateTime.now(), 8000)
  ];

  // Iterate and print the pay text and amount
  for (var payable in payables) {
    print("${payable.pay()}");
  }
}