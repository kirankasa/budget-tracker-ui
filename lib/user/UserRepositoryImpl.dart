import 'dart:async';
import 'dart:convert';
import 'package:budget_tracker/common/constants.dart';
import 'package:budget_tracker/common/exception/CommonExceptions.dart';
import 'package:budget_tracker/user/User.dart';
import 'package:http/http.dart' as http;

import 'package:budget_tracker/user/AuthenticationRequest.dart';
import 'package:budget_tracker/user/AuthenticationResponse.dart';
import 'package:budget_tracker/user/UserRepository.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<AuthenticationResponse> login(
      AuthenticationRequest authentication) async {
    String requestJson = json.encode(authentication);
    var response = await http.post(login_url,
        body: requestJson, headers: {'content-type': 'application/json'});
    final String jsonBody = response.body;
    final statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw new FetchDataException(
          "Error while logging in [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
    }
    var categoryJson = json.decode(response.body);
    return new AuthenticationResponse.fromJson(categoryJson);
  }

  @override
  Future<User> register(User user) async {
    String requestJson = json.encode(user);
    var response = await http.post(register_url,
        body: requestJson, headers: {'content-type': 'application/json'});
    final String jsonBody = response.body;
    final statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw new FetchDataException(
          "Error while sign up [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
    }
    var userJson = json.decode(response.body);
    return new User.fromJson(userJson);
  }
}