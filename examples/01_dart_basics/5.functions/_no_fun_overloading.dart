void display(Object? value) {
  if (value is String) {
    print(value.toUpperCase());
  } else {
     print(value);
  }
}

void main(List<String> args) {
  var x;
  
  print(x); // null
  print(x.runtimeType); // Null
  x = 10;
  print(x); //  10
  print(x.runtimeType); // int

  x = 'Salam';
  print(x); // Salam
  print(x.runtimeType); // String


  display(10);
  display('Salam');
  display([10, 30, 40]);
}