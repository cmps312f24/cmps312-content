//import 'package:intl/intl.dart';

extension StringExtensions on String {
  bool isPhoneNum() => length == 8; //&& allMatches(RegExp(r'\d')).length == length;
}

class Person {
  String firstName;
  final String lastName;
  final DateTime dob;
  late int id;
  String _mobile = '';

  Person(this.firstName, this.lastName, this.dob, [String? mobile]) {
    id = (1 + DateTime.now().millisecondsSinceEpoch % 100);
    if (mobile != null) {
      this.mobile = mobile;
    }
    if (age <= 0) {
      throw ArgumentError('$age is an invalid age');
    }
  }

  String get mobile => _mobile;
  set mobile(String value) {
    if (value.isPhoneNum()) {
      _mobile = value;
    } else {
      throw ArgumentError('$value is an invalid phone number');
    }
  }

  String get fullName => '$firstName $lastName';

  int get age => DateTime.now().year - dob.year;

  bool isUnderAge() => age < 18;

  @override
  String toString() => '$firstName $lastName. Age: $age';
}