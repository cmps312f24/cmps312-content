void main() {
  var numbers = [1, 3, 5, 7, 9];
  
  /*
    * The firstWhere() method returns the first element 
      that satisfies the given condition.
    * If no element satisfies the condition, it returns 
        the value provided in the orElse parameter.
    * numbers.cast<int?>() is used to treat the list 
    as having nullable integers (unfortunately, without it the
    code will not compile).

  */
  int? firstEven = numbers.cast<int?>().firstWhere(
    (number) => number! % 2 == 0, 
    orElse: () => null
  );
  
  print(firstEven); // Output: null
}
