void main() {
  final json = {
    'user': ['Lily', 13]
  };

  // Destructuring a map
  var {'user': [name, age]} = json;
  print("$name is $age years old"); // Lily is 13 years old

  /*
  JSON data typically comes from an external source over the network. 
  You need to validate it first to confirm its structure before 
  destructuring it */
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

  /*
    A pattern in an if-case statement can achieve the same JSON validation
    in a more declarative, and much less verbose way.
  */
  /*
  This case pattern simultaneously validates that:
    json is a map, because it must first match the outer map pattern to proceed.
    And, since it's a map, it also confirms json is not null.
    json contains a key user.
    The key user pairs with a list of two values.
    The types of the list values are String and int.
    The new local variables to hold the values are name and age.
  */  
  //Now: With Pattern: less verbose method of validating
  if (json case {'user': [String name, int age]}) {
    print('User $name is $age years old.');
  }
}
