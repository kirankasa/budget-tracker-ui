import 'dart:async';

import 'package:budget_tracker/login/AuthenticationRequest.dart';
import 'package:budget_tracker/login/AuthenticationResponse.dart';

abstract class LoginRepository {
  Future<AuthenticationResponse> login(AuthenticationRequest authentication);
}
