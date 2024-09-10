void main() {
  /*
    Spread operator (...)  allows you to include all elements 
    of one list inside another list
  */
  List<String> fruits = ["Apple", "Banana"];
  List<String> vegetables = ["Carrot", "Broccoli"];
  
  List<String> food = fruits + vegetables;
  print(food); // Output: [Apple, Banana, Carrot, Broccoli]

  food = [...fruits, ...vegetables];
  print(food); // Output: [Apple, Banana, Carrot, Broccoli]
}
