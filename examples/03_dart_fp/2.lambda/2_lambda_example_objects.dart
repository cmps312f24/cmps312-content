void main() {
  List<Employee> employees = [
    Employee(name: "Sara Faleh", city: "Doha", age: 30),
    Employee(name: "Mariam Saleh", city: "Istanbul", age: 22),
    Employee(name: "Ali Al-Ali", city: "Doha", age: 24),
  ];

  // Filtering employees in "Doha", mapping their ages, 
  // and calculating the average
  double avgAge = employees
      .where((employee) => employee.city == "Doha")
      .map((employee) => employee.age)
      .reduce((a, b) => a + b) /
      employees.where((employee) => employee.city == "Doha").length;

  print("Average age of employees in Doha: $avgAge");
}

class Employee {
  String name;
  String city;
  int age;

  Employee({required this.name, required this.city, required this.age});
}
