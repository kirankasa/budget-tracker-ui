import 'dart:async';
import 'package:budget_tracker/category/Category.dart';

abstract class CategoryRepository {
  Future<List<TransactionCategory>> retrieveTransactionCategories();

  Future<TransactionCategory> retrieveTransactionCategoryDetails(int id);

  Future<TransactionCategory> saveTransactionCategory(
      TransactionCategory transactionCategory);

  Future<TransactionCategory> updateTransactionCategory(
      TransactionCategory transactionCategory);
}
