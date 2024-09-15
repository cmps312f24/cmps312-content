void main() {
  // Define a list of lists
  List<List<String>> nestedList = [
    ["a", "b", "c"],
    ["d", "e", "f"]
  ];

  // Flatten the list of lists into a single list
  List<String> flattenedList = nestedList.expand((innerList) => innerList).toList();

  // Print the flattened list
  print(flattenedList); // Output: [a, b, c, d, e, f]
}