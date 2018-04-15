import 'package:budget_tracker/user/AuthenticationRequest.dart';
import 'package:budget_tracker/user/login/LoginViewPresenter.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => new _LoginViewState();
}

class _LoginViewState extends State<LoginView> implements LoginViewContract {
  String _username;
  String _password;
  final formKey = new GlobalKey<FormState>();
  LoginViewPresenter _presenter;

  _LoginViewState() {
    _presenter = new LoginViewPresenter(this);
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Text(
            "Login",
            textScaleFactor: 2.0,
          ),
          new Form(
              key: formKey,
              child: new Column(
                children: <Widget>[
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
                  )
                ],
              ))
        ],
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
    // TODO: implement showError
  }
}
