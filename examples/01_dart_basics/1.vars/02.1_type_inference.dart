void main() {

  var d;
  d.
  //d = 30;
  print(d);


int z = 20;
print(z.runtimeType); // Output: int

  String? officeNo;
  officeNo = null;  

  var len = officeNo?.length ?? 0;
  print(len);
  print('len is $len');

  print(officeNo?.toUpperCase());

  int x = 10; // Explicitly declared as int
  var y = 20; // Inferred as int

  var name = 'Ali'; // Inferred as String
  var age = 18; // Inferred as int
  var height = 1.8; // Inferred as double

  print('$name is $age years old and $height meters tall.');
  print('name variable is of type ${name.runtimeType}');
  print('age variable is of type ${age.runtimeType}');
  print('height variable is of type ${height.runtimeType}');

  var numbers = [1, 2, 3, 4, 5]; // Inferred as List<int>
  var userDetails = {
    'name': 'Bob',
    'age': 25
  }; // Inferred as Map<String, Object>

  print('Numbers: $numbers');
  print('User Details: $userDetails');
  print('Numbers variable is of type ${numbers.runtimeType}');
  print('User Details variable is of type ${userDetails.runtimeType}');

  var greet = (String name) =>
      'Hello, $name!'; // Inferred as a function returning String
  print(greet('Alice')); // Output: Hello, Alice!
  print('greet variable is of type ${greet.runtimeType}');
}
