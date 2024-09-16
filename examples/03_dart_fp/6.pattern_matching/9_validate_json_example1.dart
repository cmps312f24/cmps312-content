import 'dart:convert';

void handleUserProfile(String jsonString) {
  // Decode the JSON string into a map
  var json = jsonDecode(jsonString) as Map<String, dynamic>;

  // Use pattern matching to validate and extract fields from the JSON object
  /*
  If (json case {'name': String name, 'age': int age, 'role': String role}) 
    uses a pattern to match the structure of the JSON object.
    The pattern checks if the JSON contains the keys "name", "age", 
    and "role", and ensures the values are of the correct types 
    (String for name and role, and int for age).
  If the pattern matches, it automatically extracts the values of 
    name, age, and role into variables.
  */
  if (json case {'name': String name, 'age': int age, 'role': String role}) {
    print('Name: $name');
    print('Age: $age');
    print('Role: $role');
  } else {
    print('Invalid JSON format');
  }
}

void main() {
  // Simulated JSON data
  var validJsonString = '''
    {
      "name": "Alice",
      "age": 30,
      "role": "admin"
    }
  ''';

  var invalidJsonString = '''
    {
      "name": "Bob",
      "age": "thirty",
      "role": "user"
    }
  ''';

  print('Valid JSON:');
  handleUserProfile(validJsonString);  // Extracts and prints valid data

  print('\nInvalid JSON:');
  handleUserProfile(invalidJsonString);  // Outputs: Invalid JSON format
}
