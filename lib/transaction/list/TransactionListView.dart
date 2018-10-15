import 'package:budget_tracker/common/ui/BudgetDrawer.dart';
import 'package:budget_tracker/transaction/Transaction.dart';
import 'package:budget_tracker/transaction/TransactionPage.dart';
import 'package:budget_tracker/transaction/add/AddTransactionView.dart';
import 'package:budget_tracker/transaction/list/TransactionListPresenter.dart';
import 'package:budget_tracker/transaction/update/UpdateTransactionView.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionListView extends StatelessWidget {
  final _presenter = TransactionListPresenter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      drawer: BudgetDrawer(),
      body: FutureBuilder<TransactionPage>(
        builder:
            ((BuildContext context, AsyncSnapshot<TransactionPage> snapshot) {
          if (snapshot.hasData) {
            return ListView(
                children:
                    _buildTransactionList(context, snapshot.data.transactions));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }),
        future: _presenter.loadTransactions(),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: () => onAdd(context)),
    );
  }

  onAdd(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddTransactionView()));
  }

  List<Dismissible> _buildTransactionList(
      BuildContext context, List<Transaction> transactions) {
    return transactions
        .map((transaction) => Dismissible(
            key: Key(transaction.id.toString()),
            onDismissed: (direction) {
              _presenter.deleteTransaction(transaction.id);
              transactions.remove(transaction);
              Scaffold.of(context)
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
              "${DateFormat.yMMMd().format(transaction.dateTime)}\n${transaction.note}",
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
