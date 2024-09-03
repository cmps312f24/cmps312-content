import 'dart:math';

void main() {
  /*
  Null-aware Operator (?.): Safely accesses a property 
    or method on an object that might be null
  If the object is null, the expression evaluates 
    to null instead of throwing an error
  */
  String? name;
  // Output: null, safe access even if 'name' is null
  print(name?.length);

  // Safely access and provide a default value if null
  /*
  In this example, the code safely checks if name is null and 
  provides a default value (0) if it is, preventing 
  any potential null reference errors
  */
  int length = name?.length ?? 0;
  print('Length of name: $length'); // Output: Length of name: 0

  /*
  Null-coalescing Operator (??)
    Provides a default value if the expression on the left is null.
  */
  String? userName;
  print(userName ?? 'Guest'); // Output: 'Guest', since 'name' is null

  // Using switch expression for null-safe access
  var greeting = switch (name) {
    null => 'Hello, Guest!',      // Handle null value
    '' => 'Hello, Anonymous!',    // Handle empty string
    _ => 'Hello, $name!',         // Handle non-null, non-empty string
  };

  print(greeting); // Output: Hello, Guest!

  /*
  Null-aware Assignment Operator (??=): Assigns a value to a 
  variable only if the variable is currently null
  */
  String? email = 'mrcool@dart.dev';
  // Email is only assigned if 'email' is null
  email ??= 'info@dart.dev';
  print(email);
}
