// Define an enum for user roles
enum UserRole { admin, user, guest }

enum Color { red, yellow, blue, pink, green, purple }

String handleUserRole(UserRole role) {
  // Use a switch expression and constant patterns to return
  // a message based on the role
  return switch (role) {
    UserRole.admin => 'Welcome, Admin! You have full access.',
    UserRole.user => 'Welcome, User! You have limited access.',
    UserRole.guest => 'Welcome, Guest! You can only view public content.',
  };
}

void main() {
  // Test the function with different user roles
  print(handleUserRole(UserRole.admin));
  print(handleUserRole(UserRole.user));
  print(handleUserRole(UserRole.guest));

  // Logical-or operator in constant patterns
  var color = Color.red;
  switch (color) {
    case Color.red || Color.yellow || Color.blue:
      print('Primary color');
      break;
    case Color.pink || Color.green || Color.purple:
      print('Secondary color');
      break;
  }
}
