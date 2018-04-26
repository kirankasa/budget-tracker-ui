import 'package:budget_tracker/user/User.dart';
import 'package:budget_tracker/user/signup/SignUpViewPresenter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => new _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> implements SignUpViewContract {
  String _username;
  String _firstName;
  String _password;
  String _lastName;
  String _email;
  final formKey = new GlobalKey<FormState>();
  SignUpViewPresenter _presenter;
  _SignUpViewState() {
    _presenter = new SignUpViewPresenter(this);
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
                  height: 100.0,
                  width: 200.0,
                  padding: EdgeInsets.only(top: 20.0),
                  child: new DecoratedBox(
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                            fit: BoxFit.contain,
                            image:
                                new AssetImage("assets/expense_tracker.jpg"))),
                  ),
                ),
                new TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Username",
                  ),
                  validator: (val) =>
                      val.isEmpty ? 'Username can\'t be empty.' : null,
                  onSaved: (val) => _username = val,
                  keyboardType: TextInputType.text,
                ),
                new TextFormField(
                  decoration: new InputDecoration(
                    labelText: "First Name",
                  ),
                  validator: (val) =>
                      val.isEmpty ? 'First name can\'t be empty.' : null,
                  onSaved: (val) => _firstName = val,
                  keyboardType: TextInputType.text,
                ),
                new TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Last Name",
                  ),
                  validator: (val) =>
                      val.isEmpty ? 'Last name can\'t be empty.' : null,
                  onSaved: (val) => _lastName = val,
                  keyboardType: TextInputType.text,
                ),
                new TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Email",
                  ),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Email can\'t be empty.';
                    } else if (!val.contains("@")) {
                      return 'Please enter valid email.';
                    }
                  },
                  onSaved: (val) => _email = val,
                  keyboardType: TextInputType.emailAddress,
                ),
                new TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Password",
                  ),
                  validator: (val) =>
                      val.isEmpty ? 'Password can\'t be empty.' : null,
                  onSaved: (val) => _password = val,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                ),
                new Padding(
                  padding: new EdgeInsets.all(8.0),
                  child: new RaisedButton(
                    onPressed: () {
                      final form = formKey.currentState;
                      if (form.validate()) {
                        form.save();
                        _presenter.register(new User(
                            userName: _username,
                            firstName: _firstName,
                            lastName: _lastName,
                            password: _password,
                            email: _email));
                      }
                    },
                    child: new Text(
                      "Sign Up",
                      style: new TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 25.0),
                  child: new Center(
                    child: new RichText(
                      text: new TextSpan(children: [
                        new TextSpan(
                          text: 'Already registered? ',
                          style: new TextStyle(color: Colors.black),
                        ),
                        new TextSpan(
                          text: 'Login',
                          style: new TextStyle(color: Colors.blue),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  "/login", (Route<dynamic> route) => false);
                            },
                        )
                      ]),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  @override
  void navigateToLoginPage() {
    Navigator
        .of(context)
        .pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);
  }

  @override
  void showError() {
    // TODO: implement showError
  }
}
