import 'package:budget_tracker/user/AuthenticationRequest.dart';
import 'package:budget_tracker/user/login/LoginViewPresenter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> implements LoginViewContract {
  String _username;
  String _password;
  bool error = false;
  final formKey = GlobalKey<FormState>();
  LoginViewPresenter _presenter;

  _LoginViewState() {
    _presenter = LoginViewPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            expenseTrackerLogo(),
            error ? errorMessageWidget() : Container(),
            userNameField(),
            passwordField(),
            Container(padding: EdgeInsets.only(bottom: 25.0)),
            loginButton(),
            Container(padding: EdgeInsets.only(bottom: 40.0)),
            Center(child: signUpLink()),
          ],
        ),
      ),
    ));
  }

  @override
  void navigateToTransactionsListPage() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        "/transactions", (Route<dynamic> route) => false);
  }

  @override
  void showError() {
    setState(() {
      error = true;
    });
  }

  onLogin() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      _presenter.login(
          AuthenticationRequest(userName: _username, password: _password));
    }
  }

  onSignUp() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil("/signup", (Route<dynamic> route) => false);
  }

  Widget userNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Username",
      ),
      validator: (val) => val.isEmpty ? 'Username can\'t be empty.' : null,
      onSaved: (val) => _username = val,
    );
  }

  Widget passwordField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Password"),
      obscureText: true,
      validator: (val) => val.isEmpty ? 'Password can\'t be empty.' : null,
      onSaved: (val) => _password = val,
    );
  }

  Widget errorMessageWidget() {
    return Center(
      child: Text(
        "Invalid username or password",
        style: TextStyle(
            fontSize: 20.0, color: Colors.red, fontStyle: FontStyle.italic),
      ),
    );
  }

  Widget loginButton() {
    return RaisedButton(
      highlightColor: Colors.cyan,
      onPressed: onLogin,
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
        child: Text(
          "Login",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      textColor: Colors.white,
    );
  }

  Widget signUpLink() {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: 'New user? ',
          style: TextStyle(color: Colors.black),
        ),
        TextSpan(
          text: 'Sign up',
          style: TextStyle(color: Colors.blue),
          recognizer: TapGestureRecognizer()..onTap = onSignUp,
        )
      ]),
    );
  }

  Widget expenseTrackerLogo() {
    return Container(
      height: 100.0,
      width: 200.0,
      padding: EdgeInsets.only(top: 20.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage("assets/expense_tracker.jpg"))),
      ),
    );
  }
}
