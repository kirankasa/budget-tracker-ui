import 'package:budget_tracker/category/Category.dart';
import 'package:budget_tracker/category/details/CategoryDetailsPresenter.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CategoryDetailsView extends StatelessWidget {
  final int categoryId;

  CategoryDetailsView({Key key, @required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Details'),
      ),
      body: CategoryDetails(
        categoryId: categoryId,
      ),
    );
  }
}

class CategoryDetails extends StatefulWidget {
  final int categoryId;

  CategoryDetails({Key key, @required this.categoryId});

  @override
  State<StatefulWidget> createState() {
    return _CategoryDetailsState();
  }
}

class _CategoryDetailsState extends State<CategoryDetails>
    implements CategoryDetailsViewContract {
  CategoryDetailsPresenter _presenter;

  TransactionCategory _category;

  bool _isLoading;

  _CategoryDetailsState() {
    _presenter = CategoryDetailsPresenter(this);
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
      widget = Center(
          child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: CircularProgressIndicator()));
    } else {
      widget = Center(
          child: Padding(
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
    return Text(
      _category.category,
      style: TextStyle(fontSize: 30.0),
    );
  }
}
