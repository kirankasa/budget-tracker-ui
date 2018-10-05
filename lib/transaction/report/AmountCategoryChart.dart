import 'package:budget_tracker/common/SharedPreferencesHelper.dart';
import 'package:budget_tracker/common/ui/BudgetDrawer.dart';
import 'package:budget_tracker/transaction/AmountPerCategory.dart';
import 'package:budget_tracker/transaction/report/AmountPerCategoryPresenter.dart';
import 'package:budget_tracker/user/User.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class AmountPerCategoryChart extends StatefulWidget {
  @override
  _AmountPerCategoryChartState createState() => _AmountPerCategoryChartState();
}

class _AmountPerCategoryChartState extends State<AmountPerCategoryChart>
    implements AmountPerCategoryViewContract {
  AmountPerCategoryViewPresenter _presenter;
  bool _isLoading;
  User _loggedInUser;
  String _monthAndYear;
  String _transactionType;
  List<AmountPerCategory> _amountPerCategories;

  _AmountPerCategoryChartState() {
    _presenter = AmountPerCategoryViewPresenter(this);
  }

  @override
  initState() {
    super.initState();
    _isLoading = true;
    SharedPreferencesHelper.getLoggedInValue().then((user) {
      setState(() {
        _loggedInUser = user;
      });
    });
    _monthAndYear = DateFormat('MM-yyyy').format(DateTime.now());
    _transactionType = "D";
    _presenter.retrieveAmountPerCategory(_monthAndYear, _transactionType);
  }

  @override
  Widget build(BuildContext context) {
    var widget;

    if (_isLoading) {
      widget = Center(child: CircularProgressIndicator());
    } else
      widget = chartsWidget();

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Report'),
      ),
      drawer: BudgetDrawer(
        userName: _loggedInUser != null ? _loggedInUser.userName : "",
        email: _loggedInUser != null ? _loggedInUser.email : "",
      ),
      body: widget,
    );
  }

  Widget chartsWidget() {
    var chartSeries = [
      new charts.Series<AmountPerCategory, String>(
        id: 'AmountPerCategory',
        domainFn: (AmountPerCategory amountPerCategory, _) =>
            amountPerCategory.category,
        measureFn: (AmountPerCategory amountPerCategory, _) =>
            amountPerCategory.totalAmount,
        labelAccessorFn: (AmountPerCategory amountPerCategory, _) =>
            '${amountPerCategory.category}',
        data: _amountPerCategories,
      )
    ];
    return _amountPerCategories.length == 0
        ? Container()
        : Container(
            margin: EdgeInsets.all(16.0),
            child: _amountPerCategories.length == 1
                ? barChart(chartSeries)
                : pieChart(chartSeries));
  }

  Widget barChart(chartSeries) {
    return charts.BarChart(
      chartSeries,
      animate: true,
    );
  }

  Widget pieChart(chartSeries) {
    return charts.PieChart(chartSeries,
        animate: true,
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 100,
            arcRendererDecorators: [new charts.ArcLabelDecorator()]));
  }

  @override
  void showAmountPerCategory(List<AmountPerCategory> amountPerCategories) {
    setState(() {
      _amountPerCategories = amountPerCategories;
      _isLoading = false;
    });
  }

  @override
  void showError() {
    // TODO: implement showError
  }
}
