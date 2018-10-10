import 'dart:async';

import 'package:budget_tracker/transaction/Transaction.dart';
import 'package:budget_tracker/transaction/TransactionPage.dart';
import 'package:budget_tracker/transaction/TransactionRepository.dart';
import 'package:budget_tracker/common/di/injection.dart';

abstract class TransactionListViewContract {
  void showError();
}

class TransactionListPresenter {
  TransactionListViewContract _view;
  TransactionRepository _repository;

  TransactionListPresenter(this._view) {
    _repository = Injector().transactionRepository;
  }

  Future<TransactionPage> loadTransactions() {
  return  _repository.retrieveTransactions();
  }

  void deleteTransaction(String transactionId) {
    assert(_view != null);
    _repository.deleteTransaction(transactionId).catchError((onError) {
      print(onError);
      _view.showError();
    });
  }
}
