import 'package:budget_tracker/category/Category.dart';

abstract class TransactionFormViewContract {
  void showTransactionCategoryList(List<TransactionCategory> categories);

  void navigateToTransactionListPage();

  void showError();
}