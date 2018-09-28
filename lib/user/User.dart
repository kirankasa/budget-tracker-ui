class User {
  String userName;
  String firstName;
  String lastName;
  String email;
  String password;

  User(
      {this.userName,
      this.password,
      this.firstName,
      this.lastName,
      this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userName: json['userName'],
        password: json['password'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email']);
  }

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'email': email
      };
}
