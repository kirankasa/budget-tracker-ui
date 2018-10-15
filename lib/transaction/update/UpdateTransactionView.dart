import 'dart:async';

import 'package:budget_tracker/category/Category.dart';
import 'package:budget_tracker/common/util/DateUtil.dart';
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
  String _transactionId;
  String _selectedType;
  String _amount;
  String _note;
  String _selectedCategory;

  UpdateTransactionPresenter _presenter;
  List<TransactionCategory> _categories;
  final formKey = GlobalKey<FormState>();
  final TextEditingController _controller =  TextEditingController();

  @override
  initState() {
    super.initState();
    _isLoading = true;
    _selectedDate = widget.transaction.dateTime;
    _amount = widget.transaction.amount.toString();
    _note = widget.transaction.note.toString();
    _selectedCategory = widget.transaction.category;
    _selectedType = widget.transaction.type;
    _controller.text =  DateFormat.yMd().format(_selectedDate);
    _transactionId = widget.transaction.id;
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
                noteField(),
                Container(padding: EdgeInsets.only(bottom: 25.0)),
                updateButton(),
              ],
            )),
      );
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

  Widget categoryField() {
    return InputDecorator(
      decoration: InputDecoration(labelText: "Category"),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text("Select Category"),
          isDense: true,
          items: _categories.map((TransactionCategory category) {
            return DropdownMenuItem<String>(
              child: Text(category.category),
              value: category.category,
            );
          }).toList(),
          value: _selectedCategory,
          onChanged: (String category) {
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

  Widget amountField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Amount", hintText: "Enter Transaction Amount"),
      keyboardType: TextInputType.number,
      initialValue: _amount,
      validator: (val) => val.isEmpty ? 'Amount can\'t be empty.' : null,
      onSaved: (val) => _amount = val,
    );
  }

  Widget noteField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Note",hintText: "Enter note"),
      initialValue: _note,
      validator: (val) => val.isEmpty ? 'Note can\'t be empty.' : null,
      onSaved: (val) => _note = val,
    );
  }

  Widget transactionDateField() {
    return  Row(children: <Widget>[
       Expanded(
          child:  TextFormField(
        validator: (val) =>
        DateUtil.isValidDate(val) ? null : 'Not a valid date',
        decoration:  InputDecoration(
          hintText: 'Enter transaction date',
          labelText: 'Transaction date',
        ),
        controller: _controller,
        keyboardType: TextInputType.datetime,
      )),
       IconButton(
        icon:  Icon(Icons.date_range),
        tooltip: 'Choose date',
        onPressed: (() {
          _selectDate(context, _controller.text);
        }),
      )
    ]);
  }

  Future _selectDate(BuildContext context, String initialDateString) async {
    var now =  DateTime.now();
    var initialDate = DateUtil.convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now)
        ? initialDate
        : now);

    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate:  DateTime(1900),
        lastDate:  DateTime.now());

    if (result == null) return;

    setState(() {
      _controller.text =  DateFormat.yMd().format(result);
    });
  }

  Widget updateButton() {
    return RaisedButton(
      onPressed: onUpdate,
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
        child: Text(
          "Update",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
    );
  }

  void onUpdate() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      _presenter.updateTransaction(Transaction(
          id: _transactionId,
          category: _selectedCategory,
          amount: double.parse(_amount),
          note: _note,
          dateTime: DateUtil.convertToDate(_controller.text),
          type: _selectedType));
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
