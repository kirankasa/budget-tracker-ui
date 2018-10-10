import 'package:budget_tracker/transaction/Transaction.dart';

class TransactionPage {
  final List<Transaction> transactions;
  final int totalElements;
  final int totalPages;

  TransactionPage({this.totalElements, this.totalPages, this.transactions});

  factory TransactionPage.fromJson(Map<String, dynamic> json) {
    return TransactionPage(
      totalElements: json['totalElements'],
      totalPages: json['totalPages'],
      transactions: json['content']
          .map((transaction) => Transaction.fromJson(transaction))
          .toList(),
    );
  }
}
