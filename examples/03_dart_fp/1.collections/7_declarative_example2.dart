Iterable<(String, int)> charCountImperative(List<String> strings) {
  final List<(String, int)> charCounts = [];
  for (int i = 0; i < strings.length; ++i) {
    charCounts.add((strings[i], strings[i].length));
  }
  return charCounts;
}

Iterable<(String, int)> charCountFunctional(List<String> strings) {
  return strings.map((string) => (string, string.length));
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
