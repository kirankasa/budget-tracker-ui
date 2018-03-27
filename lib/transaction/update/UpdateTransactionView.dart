import 'dart:async';

import 'package:budget_tracker/category/Category.dart';
import 'package:budget_tracker/transaction/Transaction.dart';
import 'package:budget_tracker/transaction/update/UpdateTransactionPresenter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateTransactionView extends StatefulWidget {
  Transaction transaction;
  UpdateTransactionView(this.transaction);

  @override
  _UpdateTransactionState createState() => new _UpdateTransactionState();
}

class _UpdateTransactionState extends State<UpdateTransactionView>
    implements UpdateTransactionViewContract {
  _UpdateTransactionState() {
    _presenter = new UpdateTransactionPresenter(this);
  }

  bool _isLoading = false;
  DateTime _selectedDate;
  int _transactionId;
  String _selectedType;
  String _amount;
  String _note;
  TransactionCategory _selectedCategory;

  UpdateTransactionPresenter _presenter;
  List<TransactionCategory> _categories;
  final formKey = new GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
    _isLoading = true;
    _selectedDate = widget.transaction.dateTime;
    _amount = widget.transaction.amount.toString();
    _note = widget.transaction.note.toString();
    _selectedCategory = widget.transaction.category;
    _selectedType = widget.transaction.type;

    _transactionId = widget.transaction.id;
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
                  initialValue: _amount,
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
                  initialValue: _note,
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
                      _presenter.updateTransaction(new Transaction(
                          id: _transactionId,
                          category: _selectedCategory,
                          amount: double.parse(_amount),
                          note: _note,
                          dateTime: _selectedDate,
                          type: _selectedType));
                    }
                  },
                  child: new Text(
                    "Update",
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
        title: new Text('Update Transaction'),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.delete),
              onPressed: () {
                _presenter.deleteTransaction(_transactionId);
              })
        ],
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
