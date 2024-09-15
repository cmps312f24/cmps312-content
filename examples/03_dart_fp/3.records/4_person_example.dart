// Function returning a record with returns a record with 
// two positional fields (name, age) 
// and two named fields (city, country).
// The named fields make it clear what each value represents, 
// making the code more readable.
(String, int, {String city, String country}) getPersonDetails() {
  String name = "Bob";
  int age = 28;
  return (name, age, city: "Doha", country: "Qatar");
}

void main() {
  // Extracting values from the record
  // we unpack both positional and named fields
  var (name, age, city : suburb, :country) = getPersonDetails();
  print("Name: $name, Age: $age, Suburb: $suburb, Country: $country");
}
