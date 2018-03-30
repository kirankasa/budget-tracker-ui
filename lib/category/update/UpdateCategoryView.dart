import 'package:budget_tracker/category/Category.dart';
import 'package:budget_tracker/category/update/UpdateCategoryPresenter.dart';
import 'package:flutter/material.dart';

class UpdateCategoryView extends StatefulWidget {
  final TransactionCategory category;
  UpdateCategoryView(this.category);

  @override
  State<StatefulWidget> createState() {
    return new _UpdateCategoryState();
  }
}

class _UpdateCategoryState extends State<UpdateCategoryView>
    implements UpdateCategoryViewContract {
  int _categoryId;
  String _category;
  final formKey = new GlobalKey<FormState>();
  UpdateCategoryPresenter _presenter;

  _UpdateCategoryState() {
    _presenter = new UpdateCategoryPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _category = widget.category.category;
    _categoryId = widget.category.id;
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
                initialValue: _category,
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
                    _presenter.updateTransactionCategory(
                        new TransactionCategory(
                            id: _categoryId, category: _category));
                  }
                },
                child: new Text(
                  "Update",
                  style: new TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                color:  Theme.of(context).primaryColor,
                textColor: Colors.white,
              ),
            ),
          ],
        ));

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Update Category'),
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
