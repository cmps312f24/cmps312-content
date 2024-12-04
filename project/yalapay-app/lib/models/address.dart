class Address {
  String street = '';
  String city = '';
  String country = '';

  Address(this.street, this.city, this.country);

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      json['street'],
      json['city'],
      json['country'],
    );
  }

  bool containsText(String text) {
    return street.toLowerCase().contains(text) ||
        city.toLowerCase().contains(text) ||
        country.toLowerCase().contains(text);
  }
}