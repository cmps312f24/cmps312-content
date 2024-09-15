void main() {
  final json = {
    'user': ['Lily', 13]
  };
  var {'user': [name, age]} = json;
  print("$name is $age years old"); // Lily is 13 years old

//Before: Without patterns, validation is verbose:
  if (json is Map<String, Object?> &&
      json.length == 1 &&
      json.containsKey('user')) {
    var user = json['user'];
    if (user is List<Object> &&
        user.length == 2 &&
        user[0] is String &&
        user[1] is int) {
      var name = user[0] as String;
      var age = user[1] as int;
      print('User $name is $age years old.');
    }
  }

//Now: With Pattern: less verbose method of validating
  if (json case {'user': [String name, int age]}) {
    print('User $name is $age years old.');
  }
}
