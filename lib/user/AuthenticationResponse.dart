class AuthenticationResponse {
  final String token;

  const AuthenticationResponse({this.token});

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) {
    return  AuthenticationResponse(token: json['token']);
  }

  Map<String, dynamic> toJson() => {'token': token};
}
