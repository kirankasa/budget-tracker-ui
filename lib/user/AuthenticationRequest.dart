class AuthenticationRequest {
  final String userName;
  final String password;

  const AuthenticationRequest({this.userName, this.password});

  factory AuthenticationRequest.fromJson(Map<String, dynamic> json) {
    return new AuthenticationRequest(
        userName: json['userName'], password: json['password']);
  }

  Map<String, dynamic> toJson() => {'userName': userName, 'password': password};
}
