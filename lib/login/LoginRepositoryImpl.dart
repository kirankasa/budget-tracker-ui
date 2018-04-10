import 'dart:async';
import 'dart:convert';
import 'package:budget_tracker/common/constants.dart';
import 'package:budget_tracker/common/exception/CommonExceptions.dart';
import 'package:http/http.dart' as http;

import 'package:budget_tracker/login/AuthenticationRequest.dart';
import 'package:budget_tracker/login/AuthenticationResponse.dart';
import 'package:budget_tracker/login/LoginRepository.dart';

class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<AuthenticationResponse> login(AuthenticationRequest authentication) {
    String requestJson = json.encode(authentication);
    return http.post(login_url, body: requestJson, headers: {
      'content-type': 'application/json'
    }).then((http.Response response) {
      final String jsonBody = response.body;
      final statusCode = response.statusCode;
      if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw new FetchDataException(
            "Error while logging in [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
      }
      var categoryJson = json.decode(response.body);
      return new AuthenticationResponse.fromJson(categoryJson);
    });
  }
}
