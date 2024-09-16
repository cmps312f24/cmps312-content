String ageCategory(int age) {
  return switch (age) {
    < 13 => 'Child',
    >= 13 && < 20 => 'Teenager',
    >= 20 => 'Adult',
    _ => 'Invalid age'
  };
}

  String letterGrade(double score) {
    return switch (score) {
      >= 90 => 'Grade: A',
      >= 80 => 'Grade: B',
      >= 70 => 'Grade: C',
      >= 60 => 'Grade: D',
      < 60 => 'Grade: F',
      _ => 'Invalid score'
    };
  }


void main() {
  print(ageCategory(10)); // Outputs: Child
  print(ageCategory(15)); // Outputs: Teenager
  print(ageCategory(25)); // Outputs: Adult

  print(letterGrade(95));  // Outputs: Grade: A
  print(letterGrade(82));  // Outputs: Grade: B
  print(letterGrade(73));  // Outputs: Grade: C
}
