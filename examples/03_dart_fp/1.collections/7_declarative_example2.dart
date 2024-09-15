Iterable<(String, int)> charCountImperative(List<String> strings) {
  final List<(String, int)> charCounts = [];
  for (var s in strings) {
    charCounts.add((s, s.length));
  }
  return charCounts;
}

Iterable<(String, int)> charCountFunctional(List<String> strings) {
  return strings.map((s) => (s, s.length));
}

void main() {
  const List<String> strings  = ['dart', 'is', 'awesome'];
  var charCounts = charCountImperative(strings);
  print(charCounts);
  charCounts = charCountFunctional(strings);
  print(charCounts);

  charCounts = strings
      .where((string) => string.length > 2)
      .map((string) => (string, string.length));

  print(charCounts);
}
