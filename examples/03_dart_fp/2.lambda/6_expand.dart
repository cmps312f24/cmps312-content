void main(List<String> args) {
  List<List<String>> listOfList = [
    ["a", "b", "c"],
    ["d", "e", "f"]
  ];

  // Flattening the list of lists
  List<String> singleList = listOfList.expand((list) => list).toList();

  // Printing the result
  print(singleList); // Output: [a, b, c, d, e, f]
}