import 'package:budget_tracker/transaction/Transaction.dart';

abstract class TransactionViewContract {

  void showTransactionList(List<Transaction> transactions);

  void showError();
}