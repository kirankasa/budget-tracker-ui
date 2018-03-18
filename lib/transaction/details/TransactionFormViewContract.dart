import 'package:budget_tracker/category/Category.dart';
import 'package:budget_tracker/transaction/Transaction.dart';

abstract class TransactionFormViewContract {
  void showTransactionCategoryList(List<TransactionCategory> categories);

  void navigateToTransactionListPage();

  void showError();
}