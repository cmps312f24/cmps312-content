/*
Dart's type inference can assign types to these variables for you. 
In this case, the inferred types are List<String>, Set<String>, 
and Map<String, int>.
Or you can specify the type yourself:
final aListOfInts = <int>[];
final aSetOfInts = <int>{};
final aMapOfIntToDouble = <int, double>{};
*/
final aListOfStrings = ['one', 'two', 'three'];
final aSetOfStrings = {'one', 'two', 'three', 'one'};
final aMapOfStringsToInts = {
  'one': 1,
  'two': 2,
  'three': 3,
};

void main() {
  print(aListOfStrings);
  print(aSetOfStrings);
  print(aMapOfStringsToInts);
}