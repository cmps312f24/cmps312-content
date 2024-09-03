void main() {
  // var is Mutable: The value of a var variable can be changed
  // after it is initialized.
  var age = 25; // Dart infers 'age' as an int
  age = 30; // This is allowed because 'var' is mutable
  print(age); // Output: 30

/*
const is immutable (read-only) can only assign a value to it 
exactly one time at compile time
Compile-Time Constant: The value of a const variable must be 
known at compile-time and cannot be changed.
*/
  const double pi = 3.14; // Dart infers 'pi' as a double
  // This will cause an error since 'const' is immutable
  //pi = 3.14159;
  print(pi);

// final is Immutable: its can only be set once, but it can be
// determined at runtime (i.e., it can be initialized later
// and cannot be changed afterward).
// Runtime Constant: It is a runtime constant, meaning it
// doesn't have to be known at compile-time.
  final String todayDate;
  todayDate = DateTime.now().toString(); // Dart infers 'name' as a String
  // This will cause an error since 'final' is immutable
  //name = 'September 2024';
  print(todayDate);

  // Dart infers 'studentIds' as a List<int>
  const letterGrades = ['A', 'B+', 'B' 'C', 'D', 'F'];

  final ids = [1, 2, 3, 4, 5];
  // This is allowed as we are not changing the reference of 'ids'
  ids.add(6);
  ids[0] = 10;
  print(ids); // Output: [1, 2, 3, 4, 5, 6]
  // This will cause an error since 'final' is immutable
  //ids = [7, 8, 9];
}
