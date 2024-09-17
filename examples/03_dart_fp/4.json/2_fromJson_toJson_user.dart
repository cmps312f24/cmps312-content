import 'dart:convert';

class User {
  final String name;
  final String email;

  User(this.name, this.email);

  User.fromJson(Map<String, dynamic> json):
    name = json['name'] as String,
    email = json['email'] as String;

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };
}

void main(List<String> args) {
  var jsonString = '''
    {
      "name": "John Smith",
      "email": "john@dart.dev"
    }''';

  final userMap = jsonDecode(jsonString) as Map<String, dynamic>;
  final user = User.fromJson(userMap);

  print('Hello, ${user.name}!');
  print('We sent the verification link to ${user.email}.');

  final userJsonString = jsonEncode(user.toJson());
  print(userJsonString);
}
