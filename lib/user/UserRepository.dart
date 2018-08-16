import 'dart:async';

import 'package:budget_tracker/user/AuthenticationRequest.dart';
import 'package:budget_tracker/user/AuthenticationResponse.dart';
import 'package:budget_tracker/user/User.dart';

abstract class UserRepository {
  Future<AuthenticationResponse> login(AuthenticationRequest authentication);

  Future<User> register(User user);

  Future<User> getLoggedInUserDetails();
}
