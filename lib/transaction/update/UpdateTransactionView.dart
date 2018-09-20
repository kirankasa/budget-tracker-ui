import 'dart:async';

import 'package:budget_tracker/category/Category.dart';
import 'package:budget_tracker/transaction/Transaction.dart';
import 'package:budget_tracker/transaction/update/UpdateTransactionPresenter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateTransactionView extends StatefulWidget {
  final Transaction transaction;

  UpdateTransactionView(this.transaction);

  @override
  _UpdateTransactionState createState() => _UpdateTransactionState();
}

class _UpdateTransactionState extends State<UpdateTransactionView>
    implements UpdateTransactionViewContract {
  _UpdateTransactionState() {
    _presenter = UpdateTransactionPresenter(this);
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
  final formKey = GlobalKey<FormState>();

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
      widget = Center(
          child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: CircularProgressIndicator()));
    } else {
      widget = Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              ListTile(
                  title: DropdownButton<TransactionCategory>(
                      hint: Text("Select Category"),
                      items: _categories.map((TransactionCategory category) {
                        return DropdownMenuItem<TransactionCategory>(
                          child: Text(category.category),
                          value: category,
                        );
                      }).toList(),
                      value: _selectedCategory,
                      onChanged: (TransactionCategory category) {
                        setState(() {
                          if (category != null) {
                            _selectedCategory = category;
                          }
                        });
                      })),
              ListTile(
                  title: DropdownButton<String>(
                      hint: Text("Select Type"),
                      items: ["D", "C"].map((String type) {
                        return DropdownMenuItem<String>(
                          child: Text(type == "C" ? "Income" : "Expense"),
                          value: type,
                        );
                      }).toList(),
                      value: _selectedType,
                      onChanged: (String type) {
                        setState(() {
                          if (type != null) {
                            _selectedType = type;
                          }
                        });
                      })),
              ListTile(
                title: TextFormField(
                  decoration: InputDecoration(labelText: "Amount"),
                  keyboardType: TextInputType.number,
                  initialValue: _amount,
                  validator: (val) =>
                      val.isEmpty ? 'Amount can\'t be empty.' : null,
                  onSaved: (val) => _amount = val,
                ),
              ),
              ListTile(
                title: InputDecorator(
                  decoration: InputDecoration(
                      hintText: "Enter Date",
                      labelText: "Transaction Date",
                      labelStyle: TextStyle(fontSize: 20.0)),
                  child: Text(_selectedDate != null
                      ? DateFormat.yMMMd().format(_selectedDate)
                      : ""),
                ),
                onTap: () {
                  _selectDate(context);
                },
              ),
              ListTile(
                title: TextFormField(
                  decoration: InputDecoration(labelText: "Enter Note"),
                  initialValue: _note,
                  validator: (val) =>
                      val.isEmpty ? 'Note can\'t be empty.' : null,
                  onSaved: (val) => _note = val,
                ),
              ),
              ListTile(
                title: RaisedButton(
                  onPressed: () {
                    final form = formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      _presenter.updateTransaction(Transaction(
                          id: _transactionId,
                          category: _selectedCategory,
                          amount: double.parse(_amount),
                          note: _note,
                          dateTime: _selectedDate,
                          type: _selectedType));
                    }
                  },
                  child: Text(
                    "Update",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
              ),
            ],
          ));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Transaction'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.delete),
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
        initialDate: DateTime.now(),
        firstDate: DateTime.now().add(Duration(days: -365 * 2)),
        lastDate: DateTime.now().add(Duration(days: 365 * 2)));
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
