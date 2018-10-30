import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationApiProvider {
  Future<FirebaseUser> login(String email, String password) async {
    FirebaseUser fireBaseUser = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return fireBaseUser;
  }

  Future<FirebaseUser> registerUser(String email, String password) async {
    FirebaseUser fireBaseUser = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return fireBaseUser;
  }

  Future<FirebaseUser> currentUser(String email, String password) async {
    FirebaseUser fireBaseUser = await FirebaseAuth.instance.currentUser();
    return fireBaseUser;
  }

  Future<String> getIdToken(String email, String password) async {
    FirebaseUser fireBaseUser = await FirebaseAuth.instance.currentUser();
    String token = await fireBaseUser.getIdToken();
    return token;
  }
}
