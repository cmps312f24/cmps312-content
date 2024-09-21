void main() {
  String? maybeString = 'Hello, Good Morning';
  switch (maybeString) {
  // Matches if maybeString != null. 
  // Skip the case if its null
    case var s?:
      print(s);
  }
}