import 'package:budget_tracker/common/ui/BudgetDrawer.dart';
import 'package:budget_tracker/feedback/Feedback.dart';
import 'package:budget_tracker/feedback/FeedbackViewPresenter.dart';
import 'package:flutter/material.dart';

class FeedbackView extends StatefulWidget {
  @override
  _FeedbackViewState createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView>
    implements FeedbackViewContract {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Feedback"),
      ),
      drawer: BudgetDrawer(),
      body: Container(
        margin: EdgeInsets.all(16.0),
        child: Form(
            key: formKey,
            child: ListView(
              children: <Widget>[
                expenseTrackerLogo(),
                feedBackMessageField(),
                Container(padding: EdgeInsets.only(bottom: 25.0)),
                submitButton(),
              ],
            )),
      ),
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

  Widget feedBackMessageField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Feedback", hintText: "Please provide your feedback"),
      controller: messageController,
      maxLines: 4,
      validator: (val) => val.isEmpty ? 'Feedback can\'t be empty.' : null,
      onSaved: (val) => _message = val,
      keyboardType: TextInputType.text,
    );
  }

  Widget submitButton() {
    return RaisedButton(
      onPressed: onSubmit,
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
        child: Text(
          "Submit Feedback",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
    );
  }

  void onSubmit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      _presenter.feedback(ExpenseFeedback(message: _message));
    }
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
