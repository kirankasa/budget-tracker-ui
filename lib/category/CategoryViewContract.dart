import 'package:budget_tracker/category/Category.dart';

abstract class CategoryViewContract {

  void showCategoriesList(List<TransactionCategory> categories);

  void showError();
}