import 'package:budget_tracker/category/Category.dart';
import 'package:budget_tracker/category/details/CategoryFormPresenter.dart';
import 'package:budget_tracker/category/details/CategoryFormViewContract.dart';
import 'package:flutter/material.dart';

class CategoryFormView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Add Category'),
      ),
      body: new CategoryForm(),
    );
  }
}

class CategoryForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _CategoryFormState();
  }
}

class _CategoryFormState extends State<CategoryForm>
    implements CategoryFormViewContract {
  CategoryFormPresenter _presenter;
  TextEditingController categoryController = new TextEditingController();

  _CategoryFormState() {
    _presenter = new CategoryFormPresenter(this);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var widget = new ListView(
      children: <Widget>[
        new ListTile(
          title: new TextField(
            decoration: new InputDecoration(labelText: "Category"),
            controller: categoryController,
          ),
        ),
        new ListTile(
          title: new RaisedButton(
            onPressed: () {
              _presenter.saveTransactionCategory(
                  new TransactionCategory(category: categoryController.text));
            },
            child: new Text(
              "Add",
              style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            color: Colors.purple,
            textColor: Colors.white,
          ),
        ),
      ],
    );

    return widget;
  }

  @override
  void showError() {
    // TODO: implement showError
  }

  @override
  void navigateToCategoriesListPage() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        "/categories", (Route<dynamic> route) => false);
  }
}
