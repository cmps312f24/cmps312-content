class ContactDetails {
  String firstName = '';
  String lastName = '';
  String email = '';
  String mobile = '';

  ContactDetails(this.firstName , this.lastName,this.email, this.mobile);

  factory ContactDetails.fromJson(Map<String, dynamic> json) {
    return ContactDetails(
      json['firstName'],
      json['lastName'],
      json['email'],
      json['mobile'],
    );
  }

  bool containsText(String text) {
    return firstName.toLowerCase().contains(text) ||
        lastName.toLowerCase().contains(text) ||
        email.toLowerCase().contains(text) ||
        mobile.toLowerCase().contains(text);
  }
}