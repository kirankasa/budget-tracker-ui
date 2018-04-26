import 'package:budget_tracker/feedback/FeedbackViewPresenter.dart';
import 'package:budget_tracker/feedback/Feedback.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class FeedbackView extends StatefulWidget {
  @override
  _FeedbackViewState createState() => new _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView>
    implements FeedbackViewContract {
  String _fromEmail;
  String _message;
  TextEditingController fromEmailController = new TextEditingController();
  TextEditingController messageController = new TextEditingController();
  final formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FeedbackViewPresenter _presenter;
  _FeedbackViewState() {
    _presenter = new FeedbackViewPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
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
                    labelText: "Message",
                  ),
                  controller: messageController,
                  maxLines: 4,
                  validator: (val) =>
                      val.isEmpty ? 'Message can\'t be empty.' : null,
                  onSaved: (val) => _message = val,
                  keyboardType: TextInputType.text,
                ),
                new TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Your Email (Optional)",
                  ),
                  controller: fromEmailController,
                  onSaved: (val) => _fromEmail = val,
                  keyboardType: TextInputType.emailAddress,
                ),
                new Padding(
                  padding: new EdgeInsets.all(15.0),
                  child: new RaisedButton(
                    onPressed: () {
                      final form = formKey.currentState;
                      if (form.validate()) {
                        form.save();
                        _presenter.feedback(new ExpenseFeedback(
                            fromEmail: _fromEmail, message: _message));
                      }
                    },
                    child: new Text(
                      "Submit Feedback",
                      style: new TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                  ),
                ),
              ],
            )),
      ),
    );
  }

  @override
  void showError() {
    // TODO: implement showError
  }

  @override
  void success() {
    setState(() {
      fromEmailController.text = "";
      messageController.text = "";
    });
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(content: new Text("Feedback submitted successfully")));
  }
}
