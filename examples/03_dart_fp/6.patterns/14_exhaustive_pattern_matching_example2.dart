String describeBools(bool b1, bool b2) => switch ((b1, b2)) {
      // If you comment any of the below lines, 
      // you will get a compile-time error
      (true, true) => 'both true',
      (false, false) => 'both false',
      (true, false) => 'one of each',
      (false, true) => 'one of each',
    };

void main() {
  print(describeBools(true, true)); // both true
  print(describeBools(false, false)); // both false
  print(describeBools(true, false)); // one of each
  print(describeBools(false, true)); // one of each
}