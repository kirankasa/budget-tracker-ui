import 'package:budget_tracker/common/di/injection.dart';
import 'package:budget_tracker/transaction/AmountPerCategory.dart';
import 'package:budget_tracker/transaction/TransactionRepository.dart';

abstract class AmountPerCategoryViewContract {
  void showAmountPerCategory(List<AmountPerCategory> amountPerCategories);

  void showError();
}

class AmountPerCategoryViewPresenter {
  AmountPerCategoryViewContract _view;
  TransactionRepository _repository;

  AmountPerCategoryViewPresenter(this._view) {
    _repository = Injector().transactionRepository;
  }

  void retrieveAmountPerCategory(String monthAndYear, String transactionType) {
    assert(_view != null);

    _repository
        .retrieveAmountPerCategory(monthAndYear, transactionType)
        .then((amountPerCategories) =>
            _view.showAmountPerCategory(amountPerCategories))
        .catchError((onError) {
      print(onError);
      _view.showError();
    });
  }

  void deleteTransaction(String transactionId) {
    assert(_view != null);
    _repository.deleteTransaction(transactionId).catchError((onError) {
      print(onError);
      _view.showError();
    });
  }
}
