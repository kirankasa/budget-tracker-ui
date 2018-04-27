import 'package:budget_tracker/category/Category.dart';
import 'package:budget_tracker/category/add/AddCategoryView.dart';
import 'package:budget_tracker/category/update/UpdateCategoryView.dart';
import 'package:budget_tracker/common/SharedPreferencesHelper.dart';
import 'package:budget_tracker/common/ui/BudgetDrawer.dart';
import 'package:budget_tracker/user/User.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracker/category/list/CategoryListPresenter.dart';

class CategoryListView extends StatefulWidget {
  CategoryListView({Key key}) : super(key: key);
  @override
  _CategoryListState createState() => new _CategoryListState();
}

class _CategoryListState extends State<CategoryListView>
    implements CategoryListViewContract {
  User _loggedInUser;
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
    SharedPreferencesHelper.getLoggedinValue().then((user) {
      setState(() {
        _loggedInUser = user;
      });
    });
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
          children: _buildCategoryList());
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Categories'),
      ),
      drawer: new BudgetDrawer(
        userName: _loggedInUser != null ? _loggedInUser.userName : "",
        email: _loggedInUser != null ? _loggedInUser.email : "",
      ),
      body: widget,
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new AddCategoryView()));
          }),
    );
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

  List<_CategoryListItem> _buildCategoryList() {
    return _categories
        .map((category) => new _CategoryListItem(
            category: category,
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new UpdateCategoryView(category)));
            }))
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
