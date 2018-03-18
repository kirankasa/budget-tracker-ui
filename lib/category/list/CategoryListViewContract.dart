import 'package:budget_tracker/category/Category.dart';

abstract class CategoryListViewContract {

  void showCategoriesList(List<TransactionCategory> categories);

  void showError();
}