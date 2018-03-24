import 'package:budget_tracker/common/ui/BudgetDrawer.dart';
import 'package:budget_tracker/transaction/Transaction.dart';
import 'package:budget_tracker/transaction/details/TransactionDetailView.dart';
import 'package:budget_tracker/transaction/add/AddTransactionView.dart';
import 'package:budget_tracker/transaction/list/TransactionListPresenter.dart';
import 'package:budget_tracker/transaction/update/UpdateTransactionView.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Transactions'),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(
                Icons.add_circle,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new AddTransactionView()));
              })
        ],
      ),
      drawer: new BudgetDrawer(),
      body: new TransactionList(),
    );
  }
}

class TransactionList extends StatefulWidget {
  TransactionList({Key key}) : super(key: key);
  @override
  _TransactionListState createState() => new _TransactionListState();
}

class _TransactionListState extends State<TransactionList>
    implements TransactionListViewContract {
  TransactionListPresenter _presenter;

  List<Transaction> _transactions;

  bool _isLoading;

  _TransactionListState() {
    _presenter = new TransactionListPresenter(this);
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
          reverse: true,
          children: _buildTransactionList());
    }
    return widget;
  }

  @override
  void showError() {
    // TODO: implement showError
  }

  @override
  void showTransactionList(List<Transaction> transactions) {
    setState(() {
      _transactions = transactions;
      _isLoading = false;
    });
  }

  List<_TransactionListItem> _buildTransactionList() {
    return _transactions
        .map((transaction) => new _TransactionListItem(
            transaction: transaction,
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                          new UpdateTransactionView(transaction)));
            }))
        .toList();
  }
}

class _TransactionListItem extends ListTile {
  _TransactionListItem({Transaction transaction, GestureTapCallback onTap})
      : super(
            title: new Container(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                      child: new Text(
                    transaction.category.category,
                    style: new TextStyle(
                        fontSize: 17.0, fontWeight: FontWeight.bold),
                  )),
                  new Text(
                    transaction.amount.toString(),
                    style: new TextStyle(
                        color: transaction.type == "C"
                            ? Colors.green
                            : Colors.black,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            subtitle: new Text(
              "${new DateFormat.yMMMd().format(transaction.dateTime)}\n${transaction.note}",
              style: new TextStyle(fontSize: 17.0),
            ),
            leading: new CircleAvatar(
              child: new Text(transaction.category.category[0]),
            ),
            onTap: onTap);
}
