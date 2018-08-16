import 'package:budget_tracker/transaction/Transaction.dart';
import 'package:budget_tracker/transaction/details/TransactionDetailsPresenter.dart';
import 'package:budget_tracker/transaction/details/TransactionDetailsViewContract.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class TransactionDetailView extends StatelessWidget {
  final int transactionId;

  TransactionDetailView({Key key, @required this.transactionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Details'),
      ),
      body: TransactionDetail(
        transactionId: transactionId,
      ),
    );
  }
}

class TransactionDetail extends StatefulWidget {
  final int transactionId;

  TransactionDetail({Key key, @required this.transactionId});

  @override
  _TransactionDetailState createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail>
    implements TransactionDetailsViewContract {
  TransactionDetailsPresenter _presenter;

  Transaction _transaction;

  bool _isLoading;

  _TransactionDetailState() {
    _presenter = TransactionDetailsPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.loadTransactionDetails(widget.transactionId);
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
      widget = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildRow("Category", _transaction.category.category),
          _buildRow("Note", _transaction.note),
          _buildRow(
            "Date",
            DateFormat().add_yMd().format(_transaction.dateTime),
          ),
        ],
      );
    }
    return widget;
  }

  @override
  void showError() {
    // TODO: implement showError
  }

  @override
  void showTransactionDetails(Transaction transaction) {
    setState(() {
      _transaction = transaction;
      _isLoading = false;
    });
  }

  Widget _buildRow(String fieldName, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          fieldName,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        Text(" : "),
        Text(
          value,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}
