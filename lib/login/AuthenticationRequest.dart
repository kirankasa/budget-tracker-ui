class AuthenticationRequest {
  final String username;
  final String password;

  const AuthenticationRequest({this.username, this.password});

  factory AuthenticationRequest.fromJson(Map<String, dynamic> json) {
    return new AuthenticationRequest(
        username: json['username'], password: json['password']);
  }

  Map<String, dynamic> toJson() => {'username': username, 'password': password};
}
