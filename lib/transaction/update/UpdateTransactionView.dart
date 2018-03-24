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
  DateTime selectedDate;
  int transactionId;
  UpdateTransactionPresenter _presenter;
  List<TransactionCategory> _categories;
  TransactionCategory selectedCategory;
  String selectedType;
  TextEditingController amountController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController noteController = new TextEditingController();

  @override
  initState() {
    super.initState();
    _isLoading = true;
    selectedDate = widget.transaction.dateTime;
    amountController.text = widget.transaction.amount.toString();
    noteController.text = widget.transaction.note.toString();
    selectedCategory = widget.transaction.category;
    selectedType = widget.transaction.type;
    transactionId = widget.transaction.id;
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
      widget = new ListView(
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
                  value: selectedCategory,
                  onChanged: (TransactionCategory newCategory) {
                    setState(() {
                      if (newCategory != null) {
                        selectedCategory = newCategory;
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
                  value: selectedType,
                  onChanged: (String newType) {
                    setState(() {
                      if (newType != null) {
                        selectedType = newType;
                      }
                    });
                  })),
          new ListTile(
            title: new TextField(
              decoration: new InputDecoration(labelText: "Amount"),
              controller: amountController,
              keyboardType: TextInputType.number,
            ),
          ),
          new ListTile(
            title: new InputDecorator(
              decoration: new InputDecoration(
                  hintText: "Enter Date",
                  labelText: "Transaction Date",
                  labelStyle: new TextStyle(fontSize: 20.0)),
              child: new Text(selectedDate != null
                  ? new DateFormat.yMMMd().format(selectedDate)
                  : ""),
            ),
            onTap: () {
              _selectDate(context);
            },
          ),
          new ListTile(
            title: new TextField(
              decoration: new InputDecoration(labelText: "Enter Note"),
              controller: noteController,
            ),
          ),
          new ListTile(
            title: new RaisedButton(
              onPressed: () {
                _presenter.updateTransaction(new Transaction(
                    id: transactionId,
                    category: selectedCategory,
                    amount: double.parse(amountController.text),
                    note: noteController.text,
                    dateTime: selectedDate,
                    type: selectedType));
              },
              child: new Text(
                "Update",
                style:
                    new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              color: Colors.purple,
              textColor: Colors.white,
            ),
          ),
        ],
      );
    }
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Update Transaction'),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.delete),
              onPressed: () {
                _presenter.deleteTransaction(transactionId);
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
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
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
