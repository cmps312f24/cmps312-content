import '8.1.Person.dart';

class Faculty extends Person {
  final String office;

  Faculty(String firstName, String lastName, DateTime dob, this.office)
      : super(firstName, lastName, dob);

  @override
  String toString() => '${super.toString()}. Office: $office';
}