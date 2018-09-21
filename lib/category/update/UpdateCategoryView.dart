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
    var widget = Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          children: <Widget>[
            ListTile(
              title: TextFormField(
                decoration: InputDecoration(labelText: "Category"),
                initialValue: _category,
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
                      _presenter.updateTransactionCategory(TransactionCategory(
                          id: _categoryId, category: _category));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                    child: Text(
                      "Update",
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,),
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
        title: Text('Update Category'),
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
