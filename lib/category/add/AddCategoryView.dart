import 'package:budget_tracker/category/Category.dart';
import 'package:budget_tracker/category/add/AddCategoryPresenter.dart';
import 'package:flutter/material.dart';

class AddCategoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Add Category'),
      ),
      body: new AddCategory(),
    );
  }
}

class AddCategory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _AddCategoryState();
  }
}

class _AddCategoryState extends State<AddCategory>
    implements AddCategoryViewContract {
  AddCategoryPresenter _presenter;
  TextEditingController categoryController = new TextEditingController();

  _AddCategoryState() {
    _presenter = new AddCategoryPresenter(this);
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
