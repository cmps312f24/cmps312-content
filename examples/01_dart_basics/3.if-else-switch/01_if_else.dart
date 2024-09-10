void main() {
  var age = 16;

  print("Customer is $age years old.");

  if (age >= 18) {
    print("You can enter the movie.");
  } else if (age == 16) {
    print("You can enter the movie with your parents.");
  } else {
    print("You can not enter this movie!");
  }

  var ageCategory = "";
  if (age < 18) {
    ageCategory = "Teenager";
  } else {
    ageCategory = "Young Adult";
  }
  print('Age category: $ageCategory');

  // or using the ternary operator ?: (condition ? expr1 : expr2)
  ageCategory = age < 18 ? "Teenager" : "Young Adult";
  print('Age category (using ternary operator ?:): $ageCategory');

  // Using an if-else statement
  var year = DateTime.now().year;
  if (year >= 2001) {
    print('21st century');
  } else if (year >= 1901) {
    print('20th century');
  } else {
    print('Ancient history');
  }

  // or using the ternary operator ?: (condition ? expr1 : expr2)
  var century = year >= 2001 ? '21st century' : year >= 1901 ? '20th century' : 'Ancient history';
  print('Using ternary operator: $century');

  // or using a switch expression 
  century = switch (year) {
    >= 2001 => '21st century',
    >= 1901 => '20th century',
    _ => 'Ancient history'
  };
  print('Using switch expression: $century');
}
