import 'package:budget_tracker/category/Category.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracker/category/categoryPresenter.dart';
import 'package:budget_tracker/category/CategoryViewContract.dart';

class CategoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Categories'),
      ),
      body: new CategoryList(),
    );
  }
}

class CategoryList extends StatefulWidget {
  CategoryList({Key key}) : super(key: key);
  @override
  _CategoryListState createState() => new _CategoryListState();
}

class _CategoryListState extends State<CategoryList>
    implements CategoryViewContract {
  CategoryPresenter _presenter;

  List<TransactionCategory> _categories;

  bool _isLoading;

  _CategoryListState() {
    _presenter = new CategoryPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.loadTransactions();
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
          padding: new EdgeInsets.symmetric(vertical: 8.0),
          children: _buildTransactionList());
    }
    return widget;
  }

  @override
  void showError() {
    // TODO: implement showError
  }

  @override
  void showCategoriesList(List<TransactionCategory> categories) {
    setState(() {
      _categories = categories;
      _isLoading = false;
    });
  }

  List<_CategoryListItem> _buildTransactionList() {
    return _categories
        .map((category) =>
            new _CategoryListItem(category: category, onTap: () {}))
        .toList();
  }
}

class _CategoryListItem extends ListTile {
  _CategoryListItem({TransactionCategory category, GestureTapCallback onTap})
      : super(
            title: new Padding(
              padding: new EdgeInsets.only(left: 10.0),
              child: new Text(category.category),
            ),
            leading: new CircleAvatar(
              child: new Text(category.category[0]),
            ),
            onTap: onTap);
}
