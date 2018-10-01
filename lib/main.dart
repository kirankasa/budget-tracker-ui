import 'package:budget_tracker/category/list/CategoryListView.dart';
import 'package:budget_tracker/feedback/FeedbackView.dart';
import 'package:budget_tracker/user/login/LoginView.dart';
import 'package:budget_tracker/user/signup/SignUpView.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracker/transaction/list/TransactionListView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        inputDecorationTheme:
            InputDecorationTheme(labelStyle: TextStyle(fontSize: 20.0)),
        buttonColor: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginView(),
      routes: routes(),
    );
  }

  Map<String, WidgetBuilder> routes() {
    return {
      '/login': (BuildContext context) => LoginView(),
      '/signup': (BuildContext context) => SignUpView(),
      '/transactions': (BuildContext context) => TransactionListView(),
      '/categories': (BuildContext context) => CategoryListView(),
      '/feedback': (BuildContext context) => FeedbackView()
    };
  }
}
