import 'package:yalapay/models/customer.dart';

class CustomerArgs {
  final Customer? customer;
  final bool isAdd;

  CustomerArgs({this.customer, this.isAdd = false});
}