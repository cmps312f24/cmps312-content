/*
Nullable variables:
Dart provides null safety to help you avoid null reference exceptions.
This means that variables can't contain null unless you say they can.
In other words, types default to non-nullable.
*/

void main() {
  // Error: A value of type 'Null' can't be assigned to
  // a variable of type 'int'.
  // int a = null; // INVALID.

  // When creating a variable, add ? to the type to indicate
  // that the variable can be null:
  int? a = null; // Valid.
  // or
  // int? a; // The initial value of a is null.

  print(a); // null

  /*** Null-aware operators ***
  Dart offers some handy operators for dealing with values that 
   might be null. 
   The ??= assignment operator, which assigns a value to a variable 
   only if that variable is currently null */

  a ??= 3;
  print(a); // <-- Prints 3.

  a ??= 5;
  print(a); // <-- Still prints 3.

/*
Another null-aware operator is ??, which returns the expression 
on its left unless that expression's value is null, 
in which case it evaluates and returns the expression on its right
*/
  print(1 ?? 3); // <-- Prints 1
  print(null ?? 12); // <-- Prints 12

  /*** Conditional property access ***/
  // Use ?. to avoid errors when accessing properties of an object that might be null.
  String? str;
  print('Length ${str?.length}');
}
