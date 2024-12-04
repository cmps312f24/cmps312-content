import 'package:yalapay/models/address.dart';
import 'package:yalapay/models/contact_details.dart';

class Customer {
  String name = '';
  int id = 0;
  Address address = Address('', '', '');
  ContactDetails contactDetails = ContactDetails('', '', '', '');

  Customer(this.id, this.name, this.address, this.contactDetails);

 factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      int.parse(json['id']),
      json['companyName'],
      Address.fromJson(json['address']),
      ContactDetails.fromJson(json['contactDetails']),
    );
  }

  bool containsText(String text) {
    final lowerText = text.toLowerCase();
    return name.toLowerCase().contains(lowerText) ||
        address.containsText(lowerText) ||
        contactDetails.containsText(lowerText);
  }
}