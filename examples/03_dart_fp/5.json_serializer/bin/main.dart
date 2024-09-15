import 'dart:convert';
import 'package:json_serializer_demo/user.dart';

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
