/*
Use object pattern to check the variable type and allow easier 
type-specific handling without writing complex if-else chains 
E.g., differentiate between different user roles and 
handle them appropriately
*/
// Define user types
// Sealed class means that the class can only be extended 
// within the same library
sealed class User {}

class Admin extends User {
  final String name;
  Admin(this.name);
}

class VerifiedUser extends User {
  final String username;
  VerifiedUser(this.username);
}

class Guest extends User {}

// Define screens
String AdminDashboard(Admin admin) => "Admin Dashboard for ${admin.name}";
String UserHome(VerifiedUser user) => "User Home for ${user.username}";
String WelcomeScreen() => "Welcome to the App";

// Using if-else if to determine the screen based on user type
String getUserScreenIfElse(User user) {
  if (user is Admin) {
    return AdminDashboard(user);
  } else if (user is VerifiedUser) {
    return UserHome(user);
  } else {
    return WelcomeScreen();
  }
}

String getUserScreen(User user) {
  // Type Matching: using a switch expression to determine 
  // the screen based on the user type
  return switch (user) {
    Admin admin => AdminDashboard(admin),
    VerifiedUser verifiedUser => UserHome(verifiedUser),
    // Use can use _ if the guest user object will not be used
    Guest guest => WelcomeScreen(),
  };
}

void main() {
  // Test users
  User admin = Admin("Alice");
  User verifiedUser = VerifiedUser("john_doe");
  User guest = Guest();

  // Determine screens using if-else if
  print(getUserScreenIfElse(admin)); // Output: Admin Dashboard for Alice
  print(getUserScreenIfElse(verifiedUser)); // Output: User Home for john_doe
  print(getUserScreenIfElse(guest)); // Output: Welcome to the App

  // Using switch expression to determine the screen based on user type
  // Type Matching
  print(getUserScreen(admin)); // Output: Admin Dashboard for Alice
  print(getUserScreen(verifiedUser)); // Output: User Home for john_doe
  print(getUserScreen(guest)); // Output: Welcome to the App  
}
