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
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryListView>
    implements CategoryListViewContract {
  User _loggedInUser;
  CategoryPresenter _presenter;

  List<TransactionCategory> _categories;
  bool _isLoading;

  _CategoryListState() {
    _presenter = CategoryPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    SharedPreferencesHelper.getLoggedInValue().then((user) {
      setState(() {
        _loggedInUser = user;
      });
    });
    _presenter.loadTransactionCategories();
  }

  @override
  Widget build(BuildContext context) {
    var widget;

    if (_isLoading) {
      widget = Center(child: CircularProgressIndicator());
    } else {
      widget = Container(
        margin: EdgeInsets.all(16.0),
        child: ListView(children: _buildCategoryList()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      drawer: BudgetDrawer(
        userName: _loggedInUser != null ? _loggedInUser.userName : "",
        email: _loggedInUser != null ? _loggedInUser.email : "",
      ),
      body: widget,
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: onAdd),
    );
  }

  @override
  void showError() {
    // TODO: implement showError
  }

  onAdd() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddCategoryView()));
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
        .map((category) => _CategoryListItem(
            category: category,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateCategoryView(category)));
            }))
        .toList();
  }
}

class _CategoryListItem extends ListTile {
  _CategoryListItem({TransactionCategory category, GestureTapCallback onTap})
      : super(
            title: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(category.category),
            ),
            leading: CircleAvatar(
              child: Text(category.category[0]),
            ),
            onTap: onTap);
}
