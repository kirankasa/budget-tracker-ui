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
    var widget = Container(
      margin: EdgeInsets.all(16.0),
      child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              categoryField(),
              Container(padding: EdgeInsets.only(bottom: 25.0)),
              addButton(),
            ],
          )),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
      ),
      body: widget,
    );
  }

  onAdd() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      _presenter
          .saveTransactionCategory(TransactionCategory(category: _category));
    }
  }

  @override
  void showError() {
    // TODO: implement showError
  }

  Widget categoryField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Category", hintText: "Enter Category"),
      validator: (val) => val.isEmpty ? 'Category can\'t be empty.' : null,
      onSaved: (val) => _category = val,
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
      textColor: Colors.white,
    );
  }

  @override
  void navigateToCategoriesListPage() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        "/categories", (Route<dynamic> route) => false);
  }
}
