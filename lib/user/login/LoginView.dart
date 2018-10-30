import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../user/login/LoginBloc.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.all(16.0),
      child: ListView(
        children: <Widget>[
          expenseTrackerLogo(),
          emailField(),
          passwordField(),
          Container(padding: EdgeInsets.only(bottom: 25.0)),
          loginButton(),
          Container(padding: EdgeInsets.only(bottom: 40.0)),
          Center(child: signUpLink()),
        ],
      ),
    ));
  }

  Widget errorDialog(BuildContext context) {
    return AlertDialog(
      title: Text("Login Error"),
      content: Text("Invalid Username or Password"),
      actions: <Widget>[
        FlatButton(
          child: Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  void navigateToTransactionsListPage() {
    /* Navigator.of(context).pushNamedAndRemoveUntil(
        "/categories", (Route<dynamic> route) => false);*/
  }

  onSignUp(context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil("/signup", (Route<dynamic> route) => false);
  }

  Widget emailField() {
    return StreamBuilder(
      stream: loginBloc.email,
      builder: (context, snapshot) {
        return TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              labelText: "Email",
              hintText: "you@example.com",
              errorText: snapshot.error),
          onChanged: loginBloc.changeEmail,
        );
      },
    );
  }

  Widget passwordField() {
    return StreamBuilder(
      stream: loginBloc.password,
      builder: (context, snapshot) {
        return TextField(
          obscureText: true,
          decoration:
              InputDecoration(labelText: "Password", errorText: snapshot.error),
          onChanged: loginBloc.changePassword,
        );
      },
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
    return StreamBuilder(
        stream: loginBloc.submitValid,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return RaisedButton(
            highlightColor: Colors.cyan,
            onPressed: snapshot.hasData
                ? () => loginBloc.login(
                      onError: () => onError(context),
                      onSuccess: () => onSuccess(context),
                    )
                : null,
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
              child: Text(
                "Login",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            textColor: Colors.white,
          );
        });
  }

  onSuccess(context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil("/signup", (Route<dynamic> route) => false);
  }

  onError(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return errorDialog(context);
        });
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
          recognizer: TapGestureRecognizer()..onTap = () => onSignUp(onSignUp),
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
