import 'package:budget_tracker/transaction/Transaction.dart';

abstract class TransactionListViewContract {

  void showTransactionList(List<Transaction> transactions);

  void showError();
}