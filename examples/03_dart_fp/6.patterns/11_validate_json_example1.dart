import 'dart:convert';

({String name, int age, String role}) userFromJsonImperative(
    String jsonString) {
  // Decoding the JSON string to a Map
  Map<String, dynamic> userJson = jsonDecode(jsonString);

  // Validate and destructure the JSON manually
  if (userJson.containsKey('user') && userJson['user'] is Map) {
    var user = userJson['user'];

    if (user.containsKey('name') &&
        user['name'] is String &&
        user.containsKey('age') &&
        user['age'] is int &&
        user.containsKey('role') &&
        user['role'] is String) {
      var name = user['name'];
      var age = user['age'];
      var role = user['role'];

      // If validation passes, return the data as a record with named fields
      return (name: name, age: age, role: role);
    } else {
      throw FormatException('Invalid data types in user JSON');
    }
  } else {
    throw FormatException('Missing required fields in user JSON');
  }
}

({String name, int age, String role}) userFromJson(String jsonString) {
  // Decode the JSON string into a map
  var json = jsonDecode(jsonString) as Map<String, dynamic>;

  // Use pattern matching to validate and extract fields from the JSON object
  /*
  {
      'user': {'name': String name, 'age': int age, 'role': String role}
  }
  is a pattern to match the structure of the JSON object.
    The pattern checks if the JSON contains the user key and its
     fields "name", "age", and "role", and ensures the values 
     are of the correct types (String for name and role, and int for age)
  If the pattern matches, it automatically extracts the values of 
    name, age, and role into variables.
  */
  // Validate and destructure the JSON object using a pattern
  // If the data matched the pattern, the values are automatically extracted
  // Otherwise, it will fall to the else block and throw an exception
  if (json
      case {
        'user': {'name': String name, 'age': int age, 'role': String role}
      }) {
    return (name: name, age: age, role: role);
  } else {
    throw FormatException('Unexpected JSON format');
  }
}

void main() {
  // Simulated JSON data
  var validJsonString = '''{
    "user": {
      "name": "Alice",
      "age": 30,
      "role": "admin"
    }
  }''';

  var invalidJsonString = '''{
    "user": {
      "name": "Alice",
      "age": "thirty",
      "role": "admin"
    }
  }''';

  // Decoding the JSON string to a Map
  Map<String, dynamic> userJson = jsonDecode(validJsonString);

  // Destructuring the map using pattern matching (no validation)
  /*
  - The pattern var {'user': {'name': name, 'age': age, 'role': role}} 
    allows us to extract all fields from the user object in one step and
    store them in the name, age, and role variables.
  */
  var {'user': {'name': name, 'age': age, 'role': role}} = userJson;

  print('$name is $age years old and has the role of $role.');

  try {
    print('\nValid JSON:');
    var user = userFromJson(validJsonString);
    print('Name: ${user.name}, Age: ${user.age}, Role: ${user.role}');

    print('\nInvalid JSON:');
    user = userFromJson(invalidJsonString);
    print('Name: ${user.name}, Age: ${user.age}, Role: ${user.role}');
  } catch (e) {
    print(e);
  }

  try {
    print('\nValid JSON:');
    var user = userFromJsonImperative(validJsonString);
    print('Name: ${user.name}, Age: ${user.age}, Role: ${user.role}');

    print('\nInvalid JSON:');
    user = userFromJsonImperative(invalidJsonString);
    print('Name: ${user.name}, Age: ${user.age}, Role: ${user.role}');
  } catch (e) {
    print(e);
  }
}
