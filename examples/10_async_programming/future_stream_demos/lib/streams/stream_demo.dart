void main() async {
  print("Receiving primes");
  await for (var prime in primesStream()) {
    print("Receiving $prime");
  }
  print("Receiving end");

  await for (var symbol in symbolsStream()) {
    print("Receiving $symbol");
  }

  await for (var value in Stream.fromIterable([1, 2, 3, 4, 5])
      .where((e) => e % 2 == 0)
      .map((e) => e * e)) {
    print(value.toString());
  }

  var result = await Stream.fromIterable([1, 2, 3, 4, 5])
      .reduce((a, b) => a + b);
  print("result: $result");
}

Stream<int> primesStream() async* {
  final primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29];
  for (var prime in primes) {
    await Future.delayed(Duration(milliseconds: prime * 10));
    yield prime;
  }
}

Stream<String> symbolsStream() async* {
  yield "🌊";
  await Future.delayed(Duration(milliseconds: 500));
  yield "⚽";
  await Future.delayed(Duration(milliseconds: 300));
  yield "🎉";
}
