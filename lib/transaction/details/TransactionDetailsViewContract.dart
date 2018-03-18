import 'package:budget_tracker/transaction/Transaction.dart';

abstract class TransactionDetailsViewContract {

  void showTransactionDetails(Transaction transaction);

  void showError();
}