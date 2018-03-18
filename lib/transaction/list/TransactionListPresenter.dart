import 'package:budget_tracker/transaction/list/TransactionListViewContract.dart';
import 'package:budget_tracker/transaction/TransactionRepository.dart';
import 'package:budget_tracker/common/di/injection.dart';

class TransactionListPresenter {
  TransactionListViewContract _view;
  TransactionRepository _repository;

  TransactionListPresenter(this._view) {
    _repository = new Injector().transactionRepository;
  }

  void loadTransactions() {
    assert(_view != null);

    _repository
        .retrieveTransactions()
        .then((transactions) => _view.showTransactionList(transactions))
        .catchError((onError) {
      print(onError);
      _view.showError();
    });
  }
}
