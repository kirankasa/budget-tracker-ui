import 'package:budget_tracker/common/SharedPreferencesHelper.dart';
import 'package:budget_tracker/common/ui/BudgetDrawer.dart';
import 'package:budget_tracker/feedback/FeedbackViewPresenter.dart';
import 'package:budget_tracker/feedback/Feedback.dart';
import 'package:budget_tracker/user/User.dart';
import 'package:flutter/material.dart';

class FeedbackView extends StatefulWidget {
  @override
  _FeedbackViewState createState() => new _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView>
    implements FeedbackViewContract {
  User _loggedInUser;
  String _message;
  TextEditingController messageController = new TextEditingController();
  final formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FeedbackViewPresenter _presenter;

  _FeedbackViewState() {
    _presenter = new FeedbackViewPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    SharedPreferencesHelper.getLoggedInValue().then((user) {
      setState(() {
        _loggedInUser = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(title: new Text("Feedback"),),
      drawer: new BudgetDrawer(
        userName: _loggedInUser != null ? _loggedInUser.userName : "",
        email: _loggedInUser != null ? _loggedInUser.email : "",
      ),
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
                new Padding(
                  padding: new EdgeInsets.all(15.0),
                  child: new RaisedButton(
                    onPressed: () {
                      final form = formKey.currentState;
                      if (form.validate()) {
                        form.save();
                        _presenter
                            .feedback(new ExpenseFeedback(message: _message));
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
      messageController.text = "";
    });
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(content: new Text("Feedback submitted successfully")));
  }
}
