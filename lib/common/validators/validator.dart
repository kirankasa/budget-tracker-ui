class Validator {
  static bool isValidEmail(String email) {
    String p =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(email);
  }

  static bool isValidPassword(String password){
    return password.length > 7;
  }
}
