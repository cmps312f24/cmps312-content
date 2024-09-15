bool isEven(int n) => n % 2 == 0;
void main() {
  // Range (1 to 10 inclusive)
  List<int> nums = List.generate(10, (i) => i + 1);

  // Version 1
  bool hasEvenNumber = nums.any((n) => n.isEven);
  // Verion 2
  hasEvenNumber = nums.any(isEven);

  // Version 3 - most compact
  hasEvenNumber = nums.any((n) => n % 2 == 0);
  print("Has even number: $hasEvenNumber");

  var allEvens = nums.every((n) => n % 2 == 0);
  print('All numbers are even: $allEvens');

  var firstEven = nums.firstWhere((n) => n % 2 == 0);
  print('First even number: $firstEven');

  // Version 1
  List<int> evens = nums.where(isEven).toList();

  // Version 2
  evens = nums.where((n) => n % 2 == 0).toList();

  print("Even numbers: $evens");
}
