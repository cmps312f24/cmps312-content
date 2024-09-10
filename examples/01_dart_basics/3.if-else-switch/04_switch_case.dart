void main() {
  // switch example days of the week
  var day = 3;

  var dayName = switch (day) {
    1 => 'Monday',
    2 => 'Tuesday',
    3 => 'Wednesday',
    4 => 'Thursday',
    5 => 'Friday',
    6 => 'Saturday',
    7 => 'Sunday',
    _ => 'Invalid day'
  };

  print('Day $day is $dayName');

  switch (day) {
    case 1:
      print('Monday');
    case 2:
      print('Tuesday');
    case 3:
      print('Wednesday');
    case 4:
      print('Thursday');
    case 5:
      print('Friday');
    case 6:
      print('Saturday');
    case 7:
      print('Sunday');
    default:
      print('Invalid day');
  }

  // switch example months of the year
  var month = 8;
  switch (month) {
    case 1:
      print('January');
    case 2:
      print('February');
    case 3:
      print('March');
    case 4:
      print('April');
    case 5:
      print('May');
    case 6:
      print('June');
    case 7:
      print('July');
    case 8:
      print('August');
    case 9:
      print('September');
    case 10:
      print('October');
    case 11:
      print('November');
    case 12:
      print('December');
    default:
      print('Invalid month');
  }
}
