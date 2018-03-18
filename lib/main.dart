import 'package:budget_tracker/category/details/CategoryDetailsView.dart';
import 'package:budget_tracker/category/list/CategoryListView.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracker/transaction/list/TransactionListView.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      home: new TransactionListView(),
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
