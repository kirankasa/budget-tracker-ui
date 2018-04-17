import 'dart:async';

import 'package:budget_tracker/user/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:budget_tracker/common/di/injection.dart';
import 'package:budget_tracker/user/AuthenticationRequest.dart';
import 'package:budget_tracker/user/AuthenticationResponse.dart';
import 'package:budget_tracker/user/UserRepository.dart';

abstract class LoginViewContract {
  void navigateToTransactionsListPage();
  void showError();
}

class LoginViewPresenter {
  LoginViewContract _view;
  UserRepository _repository;
  LoginViewPresenter(this._view) {
    _repository = new Injector().userRepository;
  }

  Future login(AuthenticationRequest authenticationRequest) async {
    assert(_view != null);
    try {
      var authenticationResponse =
          await _repository.login(authenticationRequest);
      _setTokenValue(authenticationResponse);
      var user = await _repository.getLoggedInUserDetails();
      _setUserValue(user);
    } on Exception catch (e) {
      _view.showError();
    }
  }

  void _setTokenValue(AuthenticationResponse authenticationResponse) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setString("token", authenticationResponse.token);
  }

  void _setUserValue(User user) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setString("userName", user.userName);
    prefs.setString("email", user.email);
    _view.navigateToTransactionsListPage();
  }
}
