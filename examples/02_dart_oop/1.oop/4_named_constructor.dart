class Conference {
  /*
    - final properties are initialized in the constructor and do not 
    change afterward
    - fee is not final since it can be modified
  */
  final String name;
  final String city;
  final bool isFree;
  double fee;

  // Primary constructor
  // Required is used to indicate mandatory parameters
  // Setting the values (isFree = true and fee = 0.0)
  Conference({
    required this.name,
    required this.city,
  })  : isFree = true,
        fee = 0.0;

  // Named constructor for non-free conferences
  // Dart does not support secondary constructors, a named
  // constructor Conference.withFee is used instead
  Conference.withFee({
    required this.name,
    required this.city,
    required this.fee,
  }) : isFree = false;

  @override
  String toString() =>
      'Conference: $name, City: $city, Fee: $fee, Is Free: $isFree';
}

void main() {
  // Using the named constructor for a conference with a fee
  var conference =
      Conference.withFee(name: "Flutter Conference", city: "Doha", fee: 300);
  print(conference);
}
