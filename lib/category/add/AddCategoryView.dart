import 'package:budget_tracker/category/Category.dart';
import 'package:budget_tracker/category/add/AddCategoryPresenter.dart';
import 'package:flutter/material.dart';

class AddCategoryView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _AddCategoryState();
  }
}

class _AddCategoryState extends State<AddCategoryView>
    implements AddCategoryViewContract {
  final formKey = new GlobalKey<FormState>();
  String _category;

  AddCategoryPresenter _presenter;
  _AddCategoryState() {
    _presenter = new AddCategoryPresenter(this);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var widget = new Form(
        key: formKey,
        child: new ListView(
          children: <Widget>[
            new ListTile(
              title: new TextFormField(
                decoration: new InputDecoration(labelText: "Category"),
                validator: (val) =>
                    val.isEmpty ? 'Category can\'t be empty.' : null,
                onSaved: (val) => _category = val,
              ),
            ),
            new ListTile(
              title: new RaisedButton(
                onPressed: () {
                  final form = formKey.currentState;

                  if (form.validate()) {
                    form.save();
                    _presenter.saveTransactionCategory(
                        new TransactionCategory(category: _category));
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
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Add Category'),
      ),
      body: widget,
    );
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
