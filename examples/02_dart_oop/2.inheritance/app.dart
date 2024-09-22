import 'Faculty.dart';
import 'QuMember.dart';
import 'Student.dart';

void main() {
  try {
    var person =
        QuMember('Ali', 'Faleh', DateTime.parse('1990-01-12'), '1234567');
    print(person);
  } catch (e) {
    print(e);
  }

  var student1 = Student('Fatema', 'Saleh', DateTime.parse('2005-08-12'), 3.4);
  student1.firstName = 'Fatima';
  print('> Full name: ${student1.fullName}');
  print('> isUnderAge: ${student1.isUnderAge()}');
  print('> student1.toString(): $student1');

  print(
      'Studies at ${Student.university} in ${Student.city} ${Student.country}. '
      'Current year: ${Student.getCurrentYear()} ');

  var faculty1 =
      Faculty('Abbes', 'Ibn Firnas', DateTime.parse('1980-03-20'), 'C07-130');
  print('\n> faculty1.toString(): $faculty1');

  var quMembers = [student1, faculty1];
  for (var member in quMembers) {
    print(member.toString());

    if (member is Student) {
      print(member.gpa);
    }

    if (member is Faculty) {
      print(member.office);
    }
  }
}
