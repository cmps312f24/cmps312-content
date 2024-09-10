void main(List<String> args) {
  void main() {
    List<int> numbers = [1, 3, 5, 7, 9];

    // Finding the first even number or null if none exist
    int? firstEven = numbers.firstWhere(
        (num) => num % 2 == 0, // condition to find an even number
        orElse: () => null // return null if no even number is found
        );

    print(firstEven); // Output: null

    // Example with a list containing an even number
    List<int> moreNumbers = [1, 3, 4, 7, 9];

    int? firstEvenInMoreNumbers =
        moreNumbers.firstWhere((num) => num % 2 == 0, orElse: () => null);

    print(firstEvenInMoreNumbers); // Output: 4
  }
}
