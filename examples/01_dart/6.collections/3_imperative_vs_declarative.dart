void imperative() {
  /// Imperatively sum elements of a list
  const List<int> list = [1, 2, 3, 4];

  int sum = 0;
  for (int i = 0; i < list.length; ++i) {
    sum = sum + list[i];
  }
}

void functional() {
  /// Functionally sum elements of a list
  const List<int> list = [1, 2, 3, 4];

  final sum = list.fold<int>(
    0, // initial value
    (previous, current) => previous + current,
  );
}