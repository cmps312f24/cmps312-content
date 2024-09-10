import 'Payable.dart';

class Employee implements Payable {
  final String firstname;
  final String lastname;
  final double salary;

  Employee(this.firstname, this.lastname, this.salary);

  @override
  double get amount => salary;

  @override
  String pay() => "Pay by bank transfer $firstname $lastname $amount";
}