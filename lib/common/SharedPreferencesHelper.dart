import 'dart:async';

import 'package:budget_tracker/user/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<String> getTokenValue() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString("token");
    return token != null ? "Bearer " + token : null;
  }

  static Future<User> getLoggedInValue() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String email = prefs.getString("email");
    String userName = prefs.getString("userName");
    return User(userName: userName, email: email);
  }

  static void removeToken() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.remove("token");
  }
}
