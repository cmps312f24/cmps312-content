void processList(List<int> numbers) {
  switch (numbers) {
    /*
      The list pattern [var first, var second, ...] is used to extract 
      the first two elements of the list while ignoring the rest. 
      This can be useful when you need specific parts of a list.
    */
    case [var first, var second, ...]:
      print('First: $first, Second: $second');
      break;
    default:
      print('List does not match the expected pattern.');
  }
}

void main() {
  var myList = [10, 20, 30, 40];
  processList(myList); // Output: First: 10, Second: 20
}
