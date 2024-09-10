void main() {
  var fruits = ["Apple", "Banana", "Cherry", "Mango", "Orange"];

  // Destructuring the list
  // Used to unpack the list and assign its elements to 
  // the respective variables
  // ... is used to unpack the remaining elements
  var [firstFruit, secondFruit, thirdFruit, ...others] = fruits;

  print("First fruit: $firstFruit");   // Output: First fruit: Apple
  print("Second fruit: $secondFruit"); // Output: Second fruit: Banana
  print("Third fruit: $thirdFruit");   // Output: Third fruit: Cherry
  print("Others: $others");            // Output: Others: [Mango, Orange]
}