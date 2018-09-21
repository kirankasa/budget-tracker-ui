import 'package:budget_tracker/common/SharedPreferencesHelper.dart';
import 'package:budget_tracker/common/ui/BudgetDrawer.dart';
import 'package:budget_tracker/transaction/Transaction.dart';
import 'package:budget_tracker/transaction/add/AddTransactionView.dart';
import 'package:budget_tracker/transaction/list/TransactionListPresenter.dart';
import 'package:budget_tracker/transaction/update/UpdateTransactionView.dart';
import 'package:budget_tracker/user/User.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionListView extends StatefulWidget {
  TransactionListView({Key key}) : super(key: key);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionListView>
    implements TransactionListViewContract {
  User _loggedInUser;
  TransactionListPresenter _presenter;
  List<Transaction> _transactions;
  bool _isLoading;

  _TransactionListState() {
    _presenter = TransactionListPresenter(this);
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
    _presenter.loadTransactions();
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
      widget = ListView(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          children: _buildTransactionList());
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      drawer: BudgetDrawer(
        userName: _loggedInUser != null ? _loggedInUser.userName : "",
        email: _loggedInUser != null ? _loggedInUser.email : "",
      ),
      body: widget,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddTransactionView()));
            }
          }),
    );
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

  List<Dismissible> _buildTransactionList() {
    return _transactions
        .map((transaction) => Dismissible(
            key: Key(transaction.id.toString()),
            onDismissed: (direction) {
              _presenter.deleteTransaction(transaction.id);
              _transactions.remove(transaction);
              Scaffold
                  .of(context)
                  .showSnackBar(SnackBar(content: Text("Transaction deleted")));
            },
            background: LeaveBehindView(),
            child: _TransactionListItem(
                transaction: transaction,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UpdateTransactionView(transaction)));
                })))
        .toList();
  }
}

class _TransactionListItem extends ListTile {
  _TransactionListItem({Transaction transaction, GestureTapCallback onTap})
      : super(
            title: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Text(
                        transaction.category,
                        style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                      )),
                  Text(
                    transaction.amount.toString(),
                    style: TextStyle(
                        color: transaction.type == "C"
                            ? Colors.green
                            : Colors.black,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            subtitle: Text(
              "${ DateFormat.yMMMd().format(transaction.dateTime)}\n${transaction
            .note}",
              style: TextStyle(fontSize: 17.0),
            ),
            leading: CircleAvatar(
              child: Text(transaction.category[0]),
            ),
            onTap: onTap);
}

class LeaveBehindView extends StatelessWidget {
  LeaveBehindView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.red,
      child: Row(
        children: <Widget>[
          Icon(Icons.delete),
          Expanded(
            child: Text(''),
          ),
          Icon(Icons.delete),
        ],
      ),
    );
  }
}
