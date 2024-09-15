void main() {
  List<String> names = ["Farid", "Saleh", "Ali", "Sarah", "Samira", "Farida"];

  /*
    * List.of(names) creates a new copy of the names list.
    * The ..sort() is a cascade operation that calls the sort() 
      method on that newly created list and returns the 
      sorted list.
    * The sort() method takes a function as an argument 
      that compares two elements of the list.
      - If the function returns a negative value, 
        the first element is placed before the second element.
      - If the function returns a positive value,
        the second element is placed before the first element.
      - If the function returns zero, the order of 
        the elements is unchanged.
    * The two dots (..) in Dart represent the cascade operator, 
      which allows you to perform multiple operations on 
      the same object without needing to repeat the 
      object reference.
  */
  var sorted = List.of(names)..sort((a, b) => a.length.compareTo(b.length));

  // Without the cascade operator, you would have to 
  // do this in two steps:
  sorted = List.of(names);
  sorted.sort((a, b) => a.length.compareTo(b.length));

  print(names);

  print(">Sorted by length:");
  print(sorted);
}
