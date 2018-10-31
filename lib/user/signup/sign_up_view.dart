import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../user/signup/sign_up_bloc.dart';

class SignUpView extends StatelessWidget {
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
          signUpButton(),
          Container(padding: EdgeInsets.only(bottom: 40.0)),
          Center(child: loginLink(context)),
        ],
      ),
    ));
  }

  Widget errorDialog(BuildContext context) {
    return AlertDialog(
      title: Text("Sign Up Error"),
      content: Text("Error while sign up"),
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

  onSignUp(context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil("/signup", (Route<dynamic> route) => false);
  }

  Widget emailField() {
    return StreamBuilder(
      stream: signUpBloc.email,
      builder: (context, snapshot) {
        return TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              labelText: "Email",
              hintText: "you@example.com",
              errorText: snapshot.error),
          onChanged: signUpBloc.changeEmail,
        );
      },
    );
  }

  Widget passwordField() {
    return StreamBuilder(
      stream: signUpBloc.password,
      builder: (context, snapshot) {
        return TextField(
          obscureText: true,
          decoration:
              InputDecoration(labelText: "Password", errorText: snapshot.error),
          onChanged: signUpBloc.changePassword,
        );
      },
    );
  }

  Widget signUpButton() {
    return StreamBuilder(
        stream: signUpBloc.submitValid,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return RaisedButton(
            highlightColor: Colors.cyan,
            onPressed: snapshot.hasData
                ? () => signUpBloc.signUp(
                      onError: () => onError(context),
                      onSuccess: () => onSuccess(context),
                    )
                : null,
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
              child: Text(
                "Sign Up",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            textColor: Colors.white,
          );
        });
  }

  onSuccess(context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);
  }

  onError(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return errorDialog(context);
        });
  }

  Widget loginLink(context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: 'Already registered? ',
          style: TextStyle(color: Colors.black),
        ),
        TextSpan(
          text: 'Login',
          style: TextStyle(color: Colors.blue),
          recognizer: TapGestureRecognizer()..onTap = () => onSignUp(context),
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
