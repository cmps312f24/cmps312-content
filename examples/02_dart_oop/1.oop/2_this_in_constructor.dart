/*
Dart provides a handy shortcut for assigning values 
to properties in a constructor: 
use this.propertyName when declaring the constructor parameters.
*/

class Color {
  int red;
  int green;
  int blue;

  Color(this.red, this.green, this.blue);

  // Named constructor that forwards to the default one
  Color.black() : this(0, 0, 0);
  Color.white() : this(255, 255, 255);
  /* 
  In the initializer list (after the colon), 
    set red, green, and blue.
  */
  //Color.red() : this(255, 0, 0);
  Color.red() : red = 255,
                green = 0,
                blue = 0;
}

void main() {
  var color = Color(60, 80, 120);
  print(color.red);
  print(color.green);
  print(color.blue);
}