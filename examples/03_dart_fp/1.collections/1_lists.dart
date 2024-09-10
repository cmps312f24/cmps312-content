void main() {
  List<String> colors = ["Red", "Green", "Blue"];
  var names = ["Ali", "Ahmed", "Sara"];
  
  var nums = [2, 3, 4];
  var nullNums = List<int?>.filled(10, null);

  nums.add(8);
  nums.insert(0, 1);
  nums.removeAt(2);
  nums.remove(4);
  nums.removeLast();
  nums.removeRange(0, 2);
  nums.removeWhere((num) => num > 3);
  nums.removeRange(0, nums.length);
  nums.length;
  nums[1];
  nums[2] = 5;
  nums.indexOf(4);
  nums.contains(8);
  nums.addAll([1, 2, 3]);
  nums.addAll([4, 5, 6]);
  

  colors.forEach((color) => print(color));
  names.forEach((name) => print(name));
  nums.forEach((num) => print(num));
  nullNums.forEach((num) => print(num));
}