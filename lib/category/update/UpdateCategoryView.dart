import 'package:budget_tracker/category/Category.dart';
import 'package:budget_tracker/category/update/UpdateCategoryPresenter.dart';
import 'package:flutter/material.dart';

class UpdateCategoryView extends StatefulWidget {
  final TransactionCategory category;

  UpdateCategoryView(this.category);

  @override
  State<StatefulWidget> createState() {
    return _UpdateCategoryState();
  }
}

class _UpdateCategoryState extends State<UpdateCategoryView>
    implements UpdateCategoryViewContract {
  String _categoryId;
  String _category;
  final formKey = GlobalKey<FormState>();
  UpdateCategoryPresenter _presenter;

  _UpdateCategoryState() {
    _presenter = UpdateCategoryPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _category = widget.category.category;
    _categoryId = widget.category.id;
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
              updateButton(),
            ],
          )),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Category'),
      ),
      body: widget,
    );
  }

  @override
  void showError() {
    // TODO: implement showError
  }

  onUpdate() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      _presenter.updateTransactionCategory(
          TransactionCategory(id: _categoryId, category: _category));
    }
  }

  @override
  void navigateToCategoriesListPage() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        "/categories", (Route<dynamic> route) => false);
  }

  Widget categoryField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Category"),
      initialValue: _category,
      validator: (val) => val.isEmpty ? 'Category can\'t be empty.' : null,
      onSaved: (val) => _category = val,
    );
  }

  Widget updateButton() {
    return RaisedButton(
      onPressed: onUpdate,
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
        child: Text(
          "Update",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      textColor: Colors.white,
    );
  }
}
