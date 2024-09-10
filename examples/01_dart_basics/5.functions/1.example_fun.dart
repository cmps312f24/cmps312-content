void display(dynamic value) {
  if (value is String) {
    print(value.toUpperCase());
  } else {
    print(value);
  }
}

void main(List<String> args) {
  display(10);
  display('Salam');
  display([10, 30, 40]);

  print(add(10, 20));
  print(add(12.49, 4.6));
}

add(dynamic a, dynamic b) => a + b;