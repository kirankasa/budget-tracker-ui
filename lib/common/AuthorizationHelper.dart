import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class AuthorizationHelper {
  static Future<String> getTokenValue() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString("token");
    return "Bearer " + token;
  }
}
