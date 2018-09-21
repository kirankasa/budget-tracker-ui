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
        body: Theme(
      data: ThemeData(
          inputDecorationTheme:
              InputDecorationTheme(labelStyle: TextStyle(fontSize: 20.0))),
      child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              Container(
                height: 100.0,
                width: 200.0,
                padding: EdgeInsets.only(top: 20.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage("assets/expense_tracker.jpg"))),
                ),
              ),
              error
                  ? Center(
                      child: Text(
                        "Invalid username or password",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.red,
                            fontStyle: FontStyle.italic),
                      ),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.only(left: 16.0,right: 16.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Username",
                  ),
                  validator: (val) =>
                      val.isEmpty ? 'Username can\'t be empty.' : null,
                  onSaved: (val) => _username = val,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0,right: 16.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                  validator: (val) =>
                      val.isEmpty ? 'Password can\'t be empty.' : null,
                  onSaved: (val) => _password = val,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(25.0),
                child: RaisedButton(
                  highlightColor: Colors.cyan,
                  onPressed: () {
                    final form = formKey.currentState;

                    if (form.validate()) {
                      form.save();
                      _presenter.login(AuthenticationRequest(
                          userName: _username, password: _password));
                    }
                  },
                  child: Text(
                    "Login",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: Center(
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'New user? ',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: 'Sign up',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                "/signup", (Route<dynamic> route) => false);
                          },
                      )
                    ]),
                  ),
                ),
              )
            ],
          )),
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
}
