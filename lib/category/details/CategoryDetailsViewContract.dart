import 'package:budget_tracker/category/Category.dart';

abstract class CategoryDetailsViewContract{

  void showCategory(TransactionCategory category);

  void showError();
}