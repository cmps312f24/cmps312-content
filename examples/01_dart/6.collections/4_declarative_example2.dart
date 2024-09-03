void imperative() {
  /// Assign character count to strings
  const List<String> strings = ['dart', 'is', 'awesome'];

  final List<(String, int)> charCounts = [];
  for (int i = 0; i < strings.length; ++i) {
    charCounts.add((strings[i], strings[i].length));
  }
}

void functional() {
  /// Assign character count to strings
  const List<String> strings = ['dart', 'is', 'awesome'];

  final charCounts = strings.map((string) => (string, string.length));
}

void chartsCount() {
  /// Assign character count to strings and leave only
  /// the ones longer than 2 characters
  const List<String> strings = ['dart', 'is', 'awesome'];

  final charCounts = strings
      .where((string) => string.length > 2)
      .map((string) => (string, string.length));
}