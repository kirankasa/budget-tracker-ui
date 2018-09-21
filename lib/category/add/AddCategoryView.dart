import 'package:budget_tracker/category/Category.dart';
import 'package:budget_tracker/category/add/AddCategoryPresenter.dart';
import 'package:flutter/material.dart';

class AddCategoryView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddCategoryState();
  }
}

class _AddCategoryState extends State<AddCategoryView>
    implements AddCategoryViewContract {
  final formKey = GlobalKey<FormState>();
  String _category;

  AddCategoryPresenter _presenter;

  _AddCategoryState() {
    _presenter = AddCategoryPresenter(this);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var widget = Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          children: <Widget>[
            ListTile(
              title: TextFormField(
                decoration: InputDecoration(labelText: "Category"),
                validator: (val) =>
                    val.isEmpty ? 'Category can\'t be empty.' : null,
                onSaved: (val) => _category = val,
              ),
            ),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(top: 25.0, left: 16.0, right: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    final form = formKey.currentState;

                    if (form.validate()) {
                      form.save();
                      _presenter.saveTransactionCategory(
                          TransactionCategory(category: _category));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                    child: Text(
                      "Add",
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
              ),
            ),
          ],
        ));
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
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
