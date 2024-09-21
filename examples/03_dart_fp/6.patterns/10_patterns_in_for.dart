class Candidate {
  final String name;
  final int yearsExperience;

  Candidate(this.name, this.yearsExperience);
}

// Define an enum for user roles
enum UserRole { admin, user, guest }

void main() {
  var students = [('Ali', 85), ('Fatima', 90), ('Ahmed', 78)];
  /*
  Here, each record in the list of students is destructured in the 
  for loop, allowing you to directly access name and score without 
  needing to access each record's individual fields manually:
    for (var student in students) {
      var name = student.$1;
      var score = student.$2;
      print('Student: $name, Score: $score');
    }
  */
  for (var (name, score) in students) {
    print('Student: $name, Score: $score');
  }

  // Example 1: List
  List<Candidate> candidates = [
    Candidate('Alice', 3),
    Candidate('Bob', 5),
    Candidate('Charlie', 2)
  ];

  //Method 1: Without pattern
  print('\nWithout Pattern:');
  for (Candidate candidate in candidates) {
    print('${candidate.name} has ${candidate.yearsExperience} of experience.');
  }

  //Method 2: Using Pattern
  print('\nUsing Pattern:');
  for (final Candidate(:name, :yearsExperience) in candidates) {
    print('$name has $yearsExperience of experience.');
  }

// Example 2: Map
  Map<String, int> yearsExperience = {
    'Java': 8,
    'Dart': 3,
    'Python': 5,
    'JavaScript': 4
  };

  print('\n');
  for (var MapEntry(:key, value: count) in yearsExperience.entries) {
    print('$key $count years experience');
  }

  print('\n');
  for (var MapEntry(key: language, value: count) in yearsExperience.entries) {
    print('$language $count years experience');
  }

  // If-case with constant pattern in collection literals 
  // e.g., if the userRole is admin include Dashboard as a menu item they can access
  var userRole = UserRole.admin;
  var navMenuItems = [
    'Home',
    if (userRole case UserRole.admin) 'Dashboard',
    'Profile',
    'Settings'
  ];

  print('\n');
  navMenuItems.forEach(print);
}
