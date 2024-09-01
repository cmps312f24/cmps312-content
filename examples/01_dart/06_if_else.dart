void main() {
  var age = 16;

  print("User is $age years old.");

  if (age >= 18) {
    print("You can enter the movie.");
  } else if (age == 16) {
    print("You can enter the movie with your parents.");
  } else {
    print("You can not enter this movie!");
  }

  var year = DateTime.now().year;
  if (year >= 2001) {
    print('21st century');
  } else if (year >= 1901) {
    print('20th century');
  } else {
    print('Ancient history');
  }
}
