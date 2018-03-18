import 'package:budget_tracker/category/Category.dart';
import 'package:budget_tracker/category/details/CategoryDetailsPresenter.dart';
import 'package:budget_tracker/category/details/CategoryDetailsViewContract.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CategoryDetailsView extends StatelessWidget {
  final int categoryId;
  CategoryDetailsView({Key key, @required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Category Details'),
      ),
      body: new CategoryDetails(categoryId: categoryId,),
    );
  }
}

class CategoryDetails extends StatefulWidget {
  final int categoryId;
  CategoryDetails({Key key, @required this.categoryId});
  @override
  State<StatefulWidget> createState() {
    return new _CategoryDetailsState();
  }
}

class _CategoryDetailsState extends State<CategoryDetails>
    implements CategoryDetailsViewContract {
  CategoryDetailsPresenter _presenter;

  TransactionCategory _category;

  bool _isLoading;

  _CategoryDetailsState() {
    _presenter = new CategoryDetailsPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.loadTransactionDetails(widget.categoryId);
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
      widget = new Center(
          child: new Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: _buildCategoryDetails(),
      ));
    }
    return widget;
  }

  @override
  void showCategory(TransactionCategory category) {
    setState(() {
      _category = category;
      _isLoading = false;
    });
  }

  @override
  void showError() {
    // TODO: implement showError
  }

  _buildCategoryDetails() {
    return new Text(_category.category,style: new TextStyle(fontSize: 30.0),);
  }
}
