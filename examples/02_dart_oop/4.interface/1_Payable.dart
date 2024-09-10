// Abstract class is used to define an interface
abstract class Payable {
  double get amount;
  String pay();
}

// Employee class that implements Payable
class Employee implements Payable {
  final String firstname;
  final String lastname;
  final double salary;

  Employee(this.firstname, this.lastname, this.salary);

  @override
  double get amount => salary;

  @override
  String pay() => "Pay $firstname $lastname $salary";
}

// Invoice class that implements Payable
class Invoice implements Payable {
  final String invoiceDate;
  final double totalAmount;

  Invoice(this.invoiceDate, this.totalAmount);

  @override
  double get amount => totalAmount;

  @override
  String pay() => "Invoice issued on $invoiceDate of $amount is paid";
}

void main() {
  // List of payable objects
  List<Payable> payables = [
    Employee("Ali", "Faleh", 3000),
    Employee("Sara", "Saleh", 5000),
    Invoice(DateTime.now().toString(), 8000)
  ];

  // Iterate and print the pay text and amount
  for (var payable in payables) {
    print("${payable.pay()}");
  }
}
