void displayLine({String character = '*', int length = 20}) {
  var line = character * length;
  print(line);
}

/* void displayLine(double color) {
  String character = '*';
  int length = 20;
  var line = character * length;
  print(line);
} */

void main() {
  // Uses default character '*' and length 20
  displayLine();                
  // Uses provided character '=' and default length 20
  displayLine(character: '=');  
  // Uses provided character '~' and length 5
  displayLine(character: '~', length: 5); 
}
