String ageCategory(int age) {
  return switch (age) {
    < 13 => 'Child',
    >= 13 && < 20 => 'Teenager',
    >= 20 => 'Adult',
    _ => 'Invalid age'
  };
}

String getLetterGrade(double grade) {
  // Use a switch expression with relational patterns to map 
  // the grade to a letter grade
  return switch (grade) {
    >= 90       => 'A',
    >= 85 && < 90 => 'B+',
    >= 80 && < 85 => 'B',
    >= 75 && < 80 => 'C+',
    >= 70 && < 75 => 'C',
    >= 65 && < 70 => 'D+',
    >= 60 && < 65 => 'D',
    < 60        => 'F',
    _           => 'Invalid grade'
  };
}

String formatDate(DateTime dateTime) {
  final today = DateTime.now();
  final difference = dateTime.difference(today);

  return switch (difference) {
    Duration(inDays: 0) => 'today',
    Duration(inDays: 1) => 'tomorrow',
    Duration(inDays: -1) => 'yesterday',
    /*
    - A guard clause uses the when keyword after a case pattern.
    - It only add a condition to a pattern after it's matched.
    - If the guard clause evaluates to false, the entire pattern 
      is refuted, and execution proceeds to the next case.
    */
    Duration(inDays: final days) when days > 7 => '${days ~/ 7} weeks from now',
    Duration(inDays: final days) when days < -7 =>
      '${days.abs() ~/ 7} weeks ago',
    Duration(inDays: final days, isNegative: true) => '${days.abs()} days ago',
    Duration(inDays: final days) => '$days days from now',
  };
}

void main() {
  print(ageCategory(10)); // Outputs: Child
  print(ageCategory(15)); // Outputs: Teenager
  print(ageCategory(25)); // Outputs: Adult

  print(getLetterGrade(92));  // Output: A
  print(getLetterGrade(87));  // Output: B+
  print(getLetterGrade(72));  // Output: C
  print(getLetterGrade(58));  // Output: F

  print("\n");
  print(formatDate(
      DateTime.now().subtract(Duration(days: 1)))); // Outputs: yesterday
}
