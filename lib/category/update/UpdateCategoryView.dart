import 'package:budget_tracker/category/Category.dart';
import 'package:budget_tracker/category/update/UpdateCategoryPresenter.dart';
import 'package:flutter/material.dart';

class UpdateCategoryView extends StatelessWidget {
  TransactionCategory category;

  UpdateCategoryView(this.category);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Update Category'),
      ),
      body: new UpdateCategory(category),
    );
  }
}

class UpdateCategory extends StatefulWidget {
  TransactionCategory category;
  UpdateCategory(this.category);

  @override
  State<StatefulWidget> createState() {
    return new _UpdateCategoryState();
  }
}

class _UpdateCategoryState extends State<UpdateCategory>
    implements UpdateCategoryViewContract {
  int categoryId;
  UpdateCategoryPresenter _presenter;
  TextEditingController categoryController = new TextEditingController();

  _UpdateCategoryState() {
    _presenter = new UpdateCategoryPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    categoryController.text = widget.category.category;
    categoryId = widget.category.id;
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
              _presenter.updateTransactionCategory(new TransactionCategory(
                  id: categoryId, category: categoryController.text));
            },
            child: new Text(
              "Update",
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
