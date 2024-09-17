class Student {
  final String nationality;
  final double gpa;

  Student(this.nationality, this.gpa);
}

String getAdmissionDecision(student) {
    // Switch expression to determine the admission decision
  return switch (student.nationality) {
    'Qatari' when student.gpa >= 80     => 'Admitted',
    'Non-Qatari' when student.gpa >= 90 => 'Admitted',
    _ => 'Not Admitted',
  };
}

void main() {
  var student = Student('Qatari', 85);
  String admissionDecision = getAdmissionDecision(student);
  print(admissionDecision);
}
