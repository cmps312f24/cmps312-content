int sumImperative(List<int> nums) {
  /// Imperatively sum elements of a list
  var sum = 0;
  for (var n in nums) 
    sum = sum + n;
  
  return sum;
}

// Declaratively sum elements of a list
int sum(List<int> nums) =>
  nums.reduce( (acc, n) => acc + n );


void main(List<String> args) {
  const nums = [1, 2, 3, 4];
  print(sumImperative(nums)); 
  print(sum(nums));
}
