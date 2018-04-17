import 'package:budget_tracker/category/list/CategoryListView.dart';
import 'package:budget_tracker/common/SharedPreferencesHelper.dart';
import 'package:budget_tracker/user/login/LoginView.dart';
import 'package:budget_tracker/user/signup/SignUpView.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracker/transaction/list/TransactionListView.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
      home: new FutureBuilder(
        builder: ((BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return new LoginView();
          } else {
            return SignUpView();
          }
        }),
        future: SharedPreferencesHelper.getTokenValue(),
      ),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new LoginView(),
        '/signup': (BuildContext context) => new SignUpView(),
        '/transactions': (BuildContext context) => new TransactionListView(),
        '/categories': (BuildContext context) => new CategoryListView(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({this.title});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
    );
  }
}
