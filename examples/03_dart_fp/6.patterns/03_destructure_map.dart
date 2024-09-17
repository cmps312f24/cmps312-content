void main(List<String> args) {
  final user = {'userId': 1, 'fullName': 'Ali Al-Ali', 'email': 'ali@dart.dev'};
  
  // Old way!
  var userId = user['userId'];
  var userName = user['name'];
  var userEmail = user['email'];
    
  // Better way using Patterns
  // Here id, name and email are new variable declarations 
  // which holds respective values of [user] data
  final {'userId':id, 'fullName':name, 'email':email} = user;
  print("id = $id, name = $name, email = $email");
}