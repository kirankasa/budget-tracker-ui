import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../../common/validators/validator.dart';
import '../authentication_api_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpBloc {
  final _emailSubject = BehaviorSubject<String>();
  final _passwordSubject = BehaviorSubject<String>();
  final _authenticationApiProvider = AuthenticationApiProvider();

  final validateEmailTransformer =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (Validator.isValidEmail(email)) {
      sink.add(email);
    } else {
      sink.addError("Enter a valid email");
    }
  });

  final validatePasswordTransformer =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (password, sink) {
    if (Validator.isValidPassword(password)) {
      sink.add(password);
    } else {
      sink.addError("Password must be atleast 8 characters");
    }
  });

  Function(String) get changeEmail => _emailSubject.sink.add;

  Stream<String> get email =>
      _emailSubject.stream.transform(validateEmailTransformer);

  Function(String) get changePassword => _passwordSubject.sink.add;

  Stream<String> get password =>
      _passwordSubject.stream.transform(validatePasswordTransformer);

  Stream<bool> get submitValid =>
      Observable.combineLatest2(email, password, (e, p) => true);

  void signUp({Function onSuccess, Function onError}) async {
    final validEmail = _emailSubject.value;
    final validPassword = _passwordSubject.value;
    try {
      FirebaseUser user = await _authenticationApiProvider.registerUser(
          validEmail, validPassword);
      String token = await user.getIdToken();
      print("Token $token");
      onSuccess();
    } catch (e) {
      print(e);
      onError();
    }
  }

  dispose() {
    _emailSubject.close();
    _passwordSubject.close();
  }
}

final signUpBloc = SignUpBloc();
