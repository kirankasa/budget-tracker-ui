import 'dart:async';
import 'package:budget_tracker/category/Category.dart';

abstract class CategoryRepository {
  Future<List<TransactionCategory>> retrieveTransactionCategories();
}