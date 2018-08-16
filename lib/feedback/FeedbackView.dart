import 'package:budget_tracker/common/SharedPreferencesHelper.dart';
import 'package:budget_tracker/common/ui/BudgetDrawer.dart';
import 'package:budget_tracker/feedback/FeedbackViewPresenter.dart';
import 'package:budget_tracker/feedback/Feedback.dart';
import 'package:budget_tracker/user/User.dart';
import 'package:flutter/material.dart';

class FeedbackView extends StatefulWidget {
  @override
  _FeedbackViewState createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView>
    implements FeedbackViewContract {
  User _loggedInUser;
  String _message;
  TextEditingController messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FeedbackViewPresenter _presenter;

  _FeedbackViewState() {
    _presenter = FeedbackViewPresenter(this);
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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Feedback"),
      ),
      drawer: BudgetDrawer(
        userName: _loggedInUser != null ? _loggedInUser.userName : "",
        email: _loggedInUser != null ? _loggedInUser.email : "",
      ),
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
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Message",
                  ),
                  controller: messageController,
                  maxLines: 4,
                  validator: (val) =>
                      val.isEmpty ? 'Message can\'t be empty.' : null,
                  onSaved: (val) => _message = val,
                  keyboardType: TextInputType.text,
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: RaisedButton(
                    onPressed: () {
                      final form = formKey.currentState;
                      if (form.validate()) {
                        form.save();
                        _presenter.feedback(ExpenseFeedback(message: _message));
                      }
                    },
                    child: Text(
                      "Submit Feedback",
                      style: TextStyle(
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
        SnackBar(content: Text("Feedback submitted successfully")));
  }
}
