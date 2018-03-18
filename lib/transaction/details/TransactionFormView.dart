import 'package:budget_tracker/category/Category.dart';
import 'package:budget_tracker/transaction/Transaction.dart';
import 'package:budget_tracker/transaction/details/TransactionFormPresenter.dart';
import 'package:budget_tracker/transaction/details/TransactionFormViewContract.dart';
import 'package:budget_tracker/transaction/list/TransactionListView.dart';
import 'package:flutter/material.dart';

class TransactionFormView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Add Transaction'),
      ),
      body: new TransactionForm(),
    );
  }
}

class TransactionForm extends StatefulWidget {
  @override
  _TransactionFormState createState() => new _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm>
    implements TransactionFormViewContract {
  _TransactionFormState() {
    _presenter = new TransactionFormPresenter(this);
  }

  bool _isLoading = false;
  TransactionFormPresenter _presenter;
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
                  hint: new Text("Select category"),
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
                  hint: new Text("Select type"),
                  items: ["Expense", "Income"].map((String type) {
                    return new DropdownMenuItem<String>(
                      child: new Text(type),
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
              decoration: new InputDecoration(hintText: "Enter Amount"),
              controller: amountController,
            ),
          ),
          new ListTile(
            title: new TextField(
              decoration: new InputDecoration(hintText: "Enter Date"),
              controller: dateController,
            ),
          ),
          new ListTile(
            title: new TextField(
              decoration: new InputDecoration(hintText: "Enter Note"),
              controller: noteController,
            ),
          ),
          new ListTile(
            title: new RaisedButton(
              onPressed: () {
                _presenter.saveTransaction(new Transaction(
                    category: selectedCategory,
                    amount: double.parse(amountController.text),
                    note: noteController.text,
                    dateTime: new DateTime.now(),
                    type: selectedType));
              },
              child: new Text(
                "Save",
                style:
                    new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      );
    }
    return widget;
  }

  List<DropdownMenuItem<TransactionCategory>> getDropDownMenuItems() {
    List<TransactionCategory> categories = [];
    categories.add(new TransactionCategory(category: "salary", id: 1));
    categories.add(new TransactionCategory(category: "entertainment", id: 2));
    List<DropdownMenuItem<TransactionCategory>> dropDown = [];
    return categories.map((TransactionCategory category) {
      return new DropdownMenuItem<TransactionCategory>(
        child: new Text(category.category),
        value: category,
      );
    }).toList();
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
    Navigator.push(context, new MaterialPageRoute(builder: (context) => new TransactionListView()));
  }
}
