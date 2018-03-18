import 'package:budget_tracker/transaction/details/TransactionDetailsViewContract.dart';
import 'package:budget_tracker/transaction/list/TransactionListViewContract.dart';
import 'package:budget_tracker/transaction/TransactionRepository.dart';
import 'package:budget_tracker/common/di/injection.dart';

class TransactionDetailsPresenter {
  TransactionDetailsViewContract _view;
  TransactionRepository _repository;

  TransactionDetailsPresenter(this._view) {
    _repository = new Injector().transactionRepository;
  }

  void loadTransactionDetails(int transactionId) {
    assert(_view != null);

    _repository
        .retrieveTransactionDetails(transactionId)
        .then((transaction) => _view.showTransactionDetails(transaction))
        .catchError((onError) {
      print(onError);
      _view.showError();
    });
  }
}
