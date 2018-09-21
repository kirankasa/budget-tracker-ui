import 'package:budget_tracker/category/CategoryRepository.dart';
import 'package:budget_tracker/common/di/injection.dart';
import 'package:budget_tracker/transaction/Transaction.dart';
import 'package:budget_tracker/transaction/TransactionRepository.dart';

import 'package:budget_tracker/category/Category.dart';

abstract class UpdateTransactionViewContract {
  void showTransactionCategoryList(List<TransactionCategory> categories);

  void navigateToTransactionListPage();

  void showError();
}

class UpdateTransactionPresenter {
  UpdateTransactionViewContract _view;
  TransactionRepository _transactionRepository;
  CategoryRepository _categoryRepository;

  UpdateTransactionPresenter(this._view) {
    _transactionRepository = Injector().transactionRepository;
    _categoryRepository = Injector().categoryRepository;
  }

  void loadCategories() {
    assert(_view != null);
    _categoryRepository
        .retrieveTransactionCategories()
        .then((categories) => _view.showTransactionCategoryList(categories))
        .catchError((onError) {
      print(onError);
      _view.showError();
    });
  }

  void updateTransaction(Transaction transaction) {
    assert(_view != null);
    _transactionRepository
        .updateTransaction(transaction)
        .then((transaction) => _view.navigateToTransactionListPage())
        .catchError((onError) {
      print(onError);
      _view.showError();
    });
  }

  void deleteTransaction(String transactionId) {
    assert(_view != null);
    _transactionRepository
        .deleteTransaction(transactionId)
        .then((transaction) => _view.navigateToTransactionListPage())
        .catchError((onError) {
      print(onError);
      _view.showError();
    });
  }
}
