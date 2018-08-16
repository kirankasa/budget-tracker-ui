class User {
  final String userName;
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  const User(
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
