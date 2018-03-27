import 'dart:async';

import 'package:budget_tracker/category/Category.dart';
import 'package:budget_tracker/transaction/Transaction.dart';
import 'package:budget_tracker/transaction/add/AddTransactionPresenter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransactionView extends StatefulWidget {
  @override
  _AddTransactionState createState() => new _AddTransactionState();
}

class _AddTransactionState extends State<AddTransactionView>
    implements AddTransactionViewContract {
  _AddTransactionState() {
    _presenter = new AddTransactionPresenter(this);
  }

  bool _isLoading = false;
  DateTime _selectedDate = new DateTime.now();
  String _selectedType;
  String _amount;
  String _note;
  TransactionCategory _selectedCategory;
  AddTransactionPresenter _presenter;
  List<TransactionCategory> _categories;
  final formKey = new GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
    _isLoading = true;
    _presenter.loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    var widget;
    if (_isLoading) {
      widget = new Center(
          child: new Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: new CircularProgressIndicator()));
    } else {
      widget = new Form(
          key: formKey,
          child: new ListView(
            children: <Widget>[
              new ListTile(
                  title: new DropdownButton<TransactionCategory>(
                      hint: new Text("Select Category"),
                      items: _categories.map((TransactionCategory category) {
                        return new DropdownMenuItem<TransactionCategory>(
                          child: new Text(category.category),
                          value: category,
                        );
                      }).toList(),
                      value: _selectedCategory,
                      onChanged: (TransactionCategory newCategory) {
                        setState(() {
                          if (newCategory != null) {
                            _selectedCategory = newCategory;
                          }
                        });
                      })),
              new ListTile(
                  title: new DropdownButton<String>(
                      hint: new Text("Select Type"),
                      items: ["D", "C"].map((String type) {
                        return new DropdownMenuItem<String>(
                          child: new Text(type == "C" ? "Income" : "Expense"),
                          value: type,
                        );
                      }).toList(),
                      value: _selectedType,
                      onChanged: (String newType) {
                        setState(() {
                          if (newType != null) {
                            _selectedType = newType;
                          }
                        });
                      })),
              new ListTile(
                title: new TextFormField(
                  decoration: new InputDecoration(labelText: "Amount"),
                  keyboardType: TextInputType.number,
                  validator: (val) =>
                      val.isEmpty ? 'Amount can\'t be empty.' : null,
                  onSaved: (val) => _amount = val,
                ),
              ),
              new ListTile(
                title: new InputDecorator(
                  decoration: new InputDecoration(
                      hintText: "Enter Date",
                      labelText: "Transaction Date",
                      labelStyle: new TextStyle(fontSize: 20.0)),
                  child: new Text(_selectedDate != null
                      ? new DateFormat.yMMMd().format(_selectedDate)
                      : ""),
                ),
                onTap: () {
                  _selectDate(context);
                },
              ),
              new ListTile(
                title: new TextFormField(
                  decoration: new InputDecoration(labelText: "Enter Note"),
                  validator: (val) =>
                      val.isEmpty ? 'Note can\'t be empty.' : null,
                  onSaved: (val) => _note = val,
                ),
              ),
              new ListTile(
                title: new RaisedButton(
                  onPressed: () {
                    final form = formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      _presenter.saveTransaction(new Transaction(
                          category: _selectedCategory,
                          amount: double.parse(_amount),
                          note: _note,
                          dateTime: _selectedDate,
                          type: _selectedType));
                    }
                  },
                  child: new Text(
                    "Add",
                    style: new TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  color: Colors.purple,
                  textColor: Colors.white,
                ),
              ),
            ],
          ));
    }
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Add Transaction'),
      ),
      body: widget,
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().add(new Duration(days: -365 * 2)),
        lastDate: new DateTime.now().add(new Duration(days: 365 * 2)));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void showError() {
    // TODO: implement showError
  }

  @override
  void showTransactionCategoryList(List<TransactionCategory> categories) {
    setState(() {
      _categories = categories;
      _isLoading = false;
    });
  }

  @override
  void navigateToTransactionListPage() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        "/transactions", (Route<dynamic> route) => false);
  }
}
