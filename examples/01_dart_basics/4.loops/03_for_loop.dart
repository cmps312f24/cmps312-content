void main() {
  // List of names
  var names = ["Sara", "Fatima", "Ali"];

  // Loop through the list
  for (var name in names) {
    print(name);
  }

  // Loop with index and value
  for (var i = 0; i < names.length; i++) {
    print("$i -> ${names[i]}");
  }

  names.forEach((name) => print(name));
  names.forEach(print);
  
}
