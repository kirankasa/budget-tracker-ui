import 'dart:async';
import 'package:budget_tracker/transaction/AmountPerCategory.dart';
import 'package:budget_tracker/transaction/Transaction.dart';
import 'package:budget_tracker/transaction/TransactionPage.dart';

abstract class TransactionRepository {
  Future<TransactionPage> retrieveTransactions();

  Future<Transaction> retrieveTransactionDetails(String transactionId);

  Future<Transaction> saveTransaction(Transaction transaction);

  Future<Transaction> updateTransaction(Transaction transaction);

  Future<Null> deleteTransaction(String transactionId);

  Future<List<AmountPerCategory>> retrieveAmountPerCategory(String monthAndYear,
      String transactionType);
}
