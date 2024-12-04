class Users {
  String email = '';
  String password = '';
  String firstName = '';
  String lastName = '';

  Users(this.email, this.password, this.firstName, this.lastName);

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      json['email'],
      json['password'],
      json['firstName'],
      json['lastName'],
    );
  }

  @override
  String toString() {
    return 'Users{email: $email, password: $password, firstName: $firstName, lastName: $lastName}';
  }
}