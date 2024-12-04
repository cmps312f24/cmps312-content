class SimpleDate {
  final int year;
  final int month;
  final int day;

  SimpleDate(this.year, this.month, this.day);

  @override
  String toString() {
    return '$month/$day/$year'; // Format as MM/DD/YYYY
  }
}
