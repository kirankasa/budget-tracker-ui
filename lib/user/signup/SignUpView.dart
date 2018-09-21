import 'package:budget_tracker/user/User.dart';
import 'package:budget_tracker/user/signup/SignUpViewPresenter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> implements SignUpViewContract {
  String _username;
  String _firstName;
  String _password;
  String _lastName;
  String _email;
  final formKey = GlobalKey<FormState>();
  SignUpViewPresenter _presenter;

  _SignUpViewState() {
    _presenter = SignUpViewPresenter(this);
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
                Padding(
                  padding: const EdgeInsets.only(left: 16.0,right: 16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "User Name",
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Username can\'t be empty.' : null,
                    onSaved: (val) => _username = val,
                    keyboardType: TextInputType.text,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0,right: 16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "First Name",
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'First name can\'t be empty.' : null,
                    onSaved: (val) => _firstName = val,
                    keyboardType: TextInputType.text,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0,right: 16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Last Name",
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Last name can\'t be empty.' : null,
                    onSaved: (val) => _lastName = val,
                    keyboardType: TextInputType.text,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0,right: 16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
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
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0,right: 16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Password",
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Password can\'t be empty.' : null,
                    onSaved: (val) => _password = val,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.0,left: 16.0, right: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      final form = formKey.currentState;
                      if (form.validate()) {
                        form.save();
                        _presenter.register(User(
                            userName: _username,
                            firstName: _firstName,
                            lastName: _lastName,
                            password: _password,
                            email: _email));
                      }
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
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
                          text: 'Already registered? ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
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
