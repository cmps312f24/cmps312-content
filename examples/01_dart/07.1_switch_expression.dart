void main() {
  var dayOfWeek = 'Monday';
  var dayNumber = switch (dayOfWeek) {
    'Monday' => 1,
    'Tuesday' => 2,
    'Wednesday' => 3,
    'Thursday' => 4,
    'Friday' => 5,
    'Saturday' => 6,
    'Sunday' => 7,
    _ => 10, //Default value
  };
  print("Day numer is $dayNumber");

  var month = 8;
  var season = switch (month) {
    12 || 1 || 2 => "Winter",
    >= 3 && <= 4 => "Spring",
    >= 6 && <= 8 => "Summer",
    >= 9 && <= 11 => "Autumn",
    _ => "Invalid Month",
  };

  print("The season is $season.");

    var age = 20;
  var ageCategory = switch (age) {
    // If 'age' is less than 18, 'ageCategory' will be 'Teenager'
    < 18 => "Teenager",
    // Otherwise, 'ageCategory' will be 'Young Adult'
    _ => "Young Adult",
  };

  print('Age category: $ageCategory');
}
