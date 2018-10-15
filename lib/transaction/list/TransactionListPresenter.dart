import 'dart:async';

import 'package:budget_tracker/common/di/injection.dart';
import 'package:budget_tracker/transaction/TransactionPage.dart';
import 'package:budget_tracker/transaction/TransactionRepository.dart';

class TransactionListPresenter {
  TransactionRepository _repository;

  TransactionListPresenter() {
    _repository = Injector().transactionRepository;
  }

  Future<TransactionPage> loadTransactions() {
    return _repository.retrieveTransactions();
  }

  Future<Null> deleteTransaction(String transactionId) {
    return _repository.deleteTransaction(transactionId);
  }
}
