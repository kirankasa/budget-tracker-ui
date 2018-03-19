import 'package:budget_tracker/category/CategoryRepository.dart';
import 'package:budget_tracker/common/di/injection.dart';
import 'package:budget_tracker/transaction/Transaction.dart';
import 'package:budget_tracker/transaction/TransactionRepository.dart';
import 'package:budget_tracker/transaction/details/TransactionFormViewContract.dart';

class TransactionFormPresenter {
  TransactionFormViewContract _view;
  TransactionRepository _transactionRepository;
  CategoryRepository _categoryRepository;

  TransactionFormPresenter(this._view) {
    _transactionRepository = new Injector().transactionRepository;
    _categoryRepository = new Injector().categoryRepository;
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

  void saveTransaction(Transaction transaction) {
    assert(_view != null);
    _transactionRepository
        .saveTransaction(transaction)
        .then((transaction) => _view.navigateToTransactionListPage())
        .catchError((onError) {
      print(onError);
      _view.showError();
    });
  }
}
