void printStudentScores(List<(String , int )> students) {
  /*
  Here, each record in the list of students is destructured in the 
  for loop, allowing you to directly access name and score without 
  needing to access each record's individual fields manually:
  for (var student in students) {
    var name = student.$1;
    var score = student.$2;
    print('Student: $name, Score: $score');
  }
  */
  for (var (name, score) in students) {
    print('Student: $name, Score: $score');
  }
}

void main() {
  var students = [('Ali', 85), ('Fatima', 90), ('Ahmed', 78)];
  printStudentScores(students);
}
