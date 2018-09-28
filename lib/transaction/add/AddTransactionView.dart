import 'dart:async';

import 'package:budget_tracker/category/Category.dart';
import 'package:budget_tracker/transaction/Transaction.dart';
import 'package:budget_tracker/transaction/add/AddTransactionPresenter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransactionView extends StatefulWidget {
  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransactionView>
    implements AddTransactionViewContract {
  _AddTransactionState() {
    _presenter = AddTransactionPresenter(this);
  }

  bool _isLoading = false;
  DateTime _selectedDate = DateTime.now();
  String _selectedType;
  String _amount;
  String _note;
  TransactionCategory _selectedCategory;
  AddTransactionPresenter _presenter;
  List<TransactionCategory> _categories;
  final formKey = GlobalKey<FormState>();
  final TextEditingController _controller = new TextEditingController();

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
      widget = Center(child: CircularProgressIndicator());
    } else {
      widget = Container(
        margin: EdgeInsets.all(16.0),
        child: Form(
            key: formKey,
            child: ListView(
              children: <Widget>[
                categoryField(),
                transactionTypeField(),
                amountField(),
                transactionDateField(),
                transactionNotesField(),
                Container(padding: EdgeInsets.only(bottom: 25.0)),
                addButton(),
              ],
            )),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Transaction'),
      ),
      body: widget,
    );
  }

  Future _selectDate(BuildContext context, String initialDateString) async {
    var now = new DateTime.now();
    var initialDate = convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now)
        ? initialDate
        : now);

    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now());

    if (result == null) return;

    setState(() {
      _controller.text = new DateFormat.yMd().format(result);
    });
  }

  bool isValidTransactionDate(String transactionDate) {
    if (transactionDate.isEmpty) return true;
    var d = convertToDate(transactionDate);
    return d != null && d.isBefore(new DateTime.now());
  }

  DateTime convertToDate(String input) {
    try {
      var d = new DateFormat.yMd().parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }

  @override
  void showError() {
    // TODO: implement showError
  }

  Widget categoryField() {
    return InputDecorator(
      decoration: InputDecoration(labelText: "Category"),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<TransactionCategory>(
          hint: Text("Select Category"),
          isDense: true,
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
          },
        ),
      ),
    );
  }

  Widget transactionTypeField() {
    return InputDecorator(
      decoration: InputDecoration(labelText: "Transaction Type"),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
            hint: Text("Select Type"),
            isDense: true,
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
            }),
      ),
    );
  }

  @override
  void showTransactionCategoryList(List<TransactionCategory> categories) {
    setState(() {
      _categories = categories;
      _selectedCategory = _categories != null && _categories.length >= 1
          ? _categories[0]
          : null;
      _selectedType = "D";
      _isLoading = false;
    });
  }

  @override
  void navigateToTransactionListPage() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        "/transactions", (Route<dynamic> route) => false);
  }

  Widget amountField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Amount", hintText: "Enter Transaction Amount"),
      keyboardType: TextInputType.number,
      validator: (val) => val.isEmpty ? 'Amount can\'t be empty.' : null,
      onSaved: (val) => _amount = val,
    );
  }

  Widget transactionDateField() {
    return new Row(children: <Widget>[
      new Expanded(
          child: new TextFormField(
        validator: (val) =>
            isValidTransactionDate(val) ? null : 'Not a valid date',
        decoration: new InputDecoration(
          hintText: 'Enter transaction date',
          labelText: 'Transaction date',
        ),
        controller: _controller,
        keyboardType: TextInputType.datetime,
      )),
      new IconButton(
        icon: new Icon(Icons.date_range),
        tooltip: 'Choose date',
        onPressed: (() {
          _selectDate(context, _controller.text);
        }),
      )
    ]);
  }

  Widget transactionNotesField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Notes", hintText: "Enter Notes"),
      validator: (val) => val.isEmpty ? 'Note can\'t be empty.' : null,
      onSaved: (val) => _note = val,
    );
  }

  Widget addButton() {
    return RaisedButton(
      onPressed: onAdd,
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
        child: Text(
          "Add",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
    );
  }

  void onAdd() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      _presenter.saveTransaction(Transaction(
          category: _selectedCategory.category,
          amount: double.parse(_amount),
          note: _note,
          dateTime: _selectedDate,
          type: _selectedType));
    }
  }
}
