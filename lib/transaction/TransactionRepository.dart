import 'dart:async';
import 'package:budget_tracker/transaction/Transaction.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> retrieveTransactions();

  Future<Transaction> retrieveTransactionDetails(int transactionId);

  Future<Transaction> saveTransaction(Transaction transaction);

  Future<Transaction> updateTransaction(Transaction transaction);

  Future<Null> deleteTransaction(int transactionId);
}