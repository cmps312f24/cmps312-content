void main(List<String> args) {
  final user = {'id': 1, 'name': 'Ali', 'email': 'ali@dart.dev'};
  
  // Before:
  final userId = user['id'];
  final userName = user['name'];
  final userEmail = user['email'];
    
  // Now: Using Patterns
  // Here uID, uName and uEmail are new variable declarations 
  // which holds respective values of [user] data
  // For more, see Record and Object pattern type below
  final {'id':id, 'name':name, 'email':email} = user;
  print("$id - $name - $email");
}