int sumOld(List<int> list) {
  /// Imperatively sum elements of a list
  const list = [1, 2, 3, 4];

  int sum = 0;
  for (int i = 0; i < list.length; ++i) {
    sum = sum + list[i];
  }
  return sum;
}

// Declaratively sum elements of a list
int sum(List<int> list) =>
 list.reduce( (acc, n) => acc + n );


void main(List<String> args) {
  const list = [1, 2, 3, 4];
  print(sumOld(list)); 
  print(sum(list));
}
