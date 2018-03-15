import 'package:budget_tracker/transaction/TransactionViewContract.dart';
import 'package:budget_tracker/transaction/TransactionRepository.dart';
import 'package:budget_tracker/common/di/injection.dart';

class TransactionPresenter {
  TransactionViewContract _view;
  TransactionRepository _repository;

  TransactionPresenter(this._view) {
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
