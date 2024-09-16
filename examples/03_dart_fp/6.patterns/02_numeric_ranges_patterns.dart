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

  print(letterGrade(95)); // Outputs: Grade: A
  print(letterGrade(82)); // Outputs: Grade: B
  print(letterGrade(73)); // Outputs: Grade: C

  print("\n");
  print(formatDate(
      DateTime.now().subtract(Duration(days: 1)))); // Outputs: yesterday
}
