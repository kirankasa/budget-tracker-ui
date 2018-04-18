import 'package:budget_tracker/user/AuthenticationRequest.dart';
import 'package:budget_tracker/user/login/LoginViewPresenter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => new _LoginViewState();
}

class _LoginViewState extends State<LoginView> implements LoginViewContract {
  String _username;
  String _password;
  bool error = false;
  final formKey = new GlobalKey<FormState>();
  LoginViewPresenter _presenter;

  _LoginViewState() {
    _presenter = new LoginViewPresenter(this);
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Theme(
      data: new ThemeData(
          inputDecorationTheme: new InputDecorationTheme(
              labelStyle: new TextStyle(fontSize: 20.0))),
      child: new Form(
          key: formKey,
          child: new ListView(
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.all(20.0),
                child: new FlutterLogo(size: 100.0, colors: Colors.blue, ),
              ),
              error
                  ? new Center(
                      child: new Text(
                        "Invalid username or password",
                        style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.red,
                            fontStyle: FontStyle.italic),
                      ),
                    )
                  : new Container(),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: "Username",
                ),
                validator: (val) =>
                    val.isEmpty ? 'Username can\'t be empty.' : null,
                onSaved: (val) => _username = val,
              ),
              new TextFormField(
                decoration: new InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (val) =>
                    val.isEmpty ? 'Password can\'t be empty.' : null,
                onSaved: (val) => _password = val,
              ),
              new Padding(
                padding: new EdgeInsets.all(8.0),
                child: new RaisedButton(
                  highlightColor: Colors.cyan,
                  onPressed: () {
                    final form = formKey.currentState;

                    if (form.validate()) {
                      form.save();
                      _presenter.login(new AuthenticationRequest(
                          userName: _username, password: _password));
                    }
                  },
                  child: new Text(
                    "Login",
                    style: new TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
              ),
              new Padding(
                padding: new EdgeInsets.only(top: 25.0),
                child: Center(
                  child: new RichText(
                    text: new TextSpan(children: [
                      new TextSpan(
                        text: 'New user? ',
                        style: new TextStyle(color: Colors.black),
                      ),
                      new TextSpan(
                        text: 'Sign up',
                        style: new TextStyle(color: Colors.blue),
                        recognizer: new TapGestureRecognizer()
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
