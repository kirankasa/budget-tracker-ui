import 'package:budget_tracker/user/User.dart';
import 'package:budget_tracker/user/signup/SignUpViewPresenter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> implements SignUpViewContract {
  var newUser = User();
  final formKey = GlobalKey<FormState>();
  SignUpViewPresenter _presenter;

  _SignUpViewState() {
    _presenter = SignUpViewPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(16.0),
        child: signUpForm(),
      ),
    );
  }

  Widget signUpForm() {
    return Form(
      key: formKey,
      child: ListView(
        children: <Widget>[
          expenseTrackerLogo(),
          userNameField(),
          firstNameField(),
          lastNameField(),
          emailField(),
          passwordField(),
          Container(padding: EdgeInsets.only(bottom: 25.0)),
          signupButton(),
          Container(padding: EdgeInsets.only(bottom: 40.0)),
          Center(child: loginLink())
        ],
      ),
    );
  }

  @override
  void navigateToLoginPage() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);
  }

  @override
  void showError() {
    // TODO: implement showError
  }

  onLogin() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);
  }

  onSignUp() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      _presenter.register(newUser);
    }
  }

  Widget userNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "User Name",
      ),
      validator: (val) => val.isEmpty ? 'Username can\'t be empty.' : null,
      onSaved: (val) => newUser.userName = val,
      keyboardType: TextInputType.text,
    );
  }

  Widget firstNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "First Name",
      ),
      validator: (val) => val.isEmpty ? 'First name can\'t be empty.' : null,
      onSaved: (val) => newUser.firstName = val,
      keyboardType: TextInputType.text,
    );
  }

  Widget lastNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Last Name",
      ),
      validator: (val) => val.isEmpty ? 'Last name can\'t be empty.' : null,
      onSaved: (val) => newUser.lastName = val,
      keyboardType: TextInputType.text,
    );
  }

  Widget emailField() {
    return TextFormField(
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
      onSaved: (val) => newUser.email = val,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget passwordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Password",
      ),
      validator: (val) => val.isEmpty ? 'Password can\'t be empty.' : null,
      onSaved: (val) => newUser.password = val,
      keyboardType: TextInputType.text,
      obscureText: true,
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

  Widget signupButton() {
    return RaisedButton(
      onPressed: onSignUp,
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
        child: Text(
          "Sign Up",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      textColor: Colors.white,
    );
  }

  Widget loginLink() {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: 'Already registered? ',
          style: TextStyle(color: Colors.black),
        ),
        TextSpan(
          text: 'Login',
          style: TextStyle(color: Colors.blue),
          recognizer: TapGestureRecognizer()..onTap = onLogin,
        )
      ]),
    );
  }
}
