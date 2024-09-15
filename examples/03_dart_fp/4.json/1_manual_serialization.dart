import 'dart:convert';

void main() {
 var jsonString = '''
    {
      "name": "John Smith",
      "email": "john@dart.dev"
    }
''';

  // Parse the JSON string into a Map
  // jsonDecode() returns a dynamic, meaning that you do not know 
  // the types of the values until runtime
  // You lose statically typed language features: type safety, 
  //  autocompletion and most importantly, compile-time exceptions
  final user = jsonDecode(jsonString) as Map<String, dynamic>;

  print('Hello, ${user['name']}!');
  print('We sent the verification link to ${user['email']}.');

  final userJsonString = jsonEncode(user);
  print(userJsonString);
}