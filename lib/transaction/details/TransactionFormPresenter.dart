import 'package:budget_tracker/category/CategoryRepository.dart';
import 'package:budget_tracker/common/di/injection.dart';
import 'package:budget_tracker/transaction/Transaction.dart';
import 'package:budget_tracker/transaction/TransactionRepository.dart';
import 'package:budget_tracker/transaction/details/TransactionFormViewContract.dart';

class TransactionFormPresenter {
  TransactionFormViewContract _view;
  TransactionRepository _transaction_repository;
  CategoryRepository _category_repository;

  TransactionFormPresenter(this._view){
    _transaction_repository = new Injector().transactionRepository;
    _category_repository = new Injector().categoryRepository;
  }

  void loadCategories() {
    assert(_view != null);
    _category_repository
        .retrieveTransactionCategories()
        .then((categories) => _view.showTransactionCategoryList(categories))
        .catchError((onError) {
      print(onError);
      _view.showError();
    });
  }

  void saveTransaction(Transaction transaction) {
    assert(_view != null);
    _transaction_repository.saveTransaction(transaction);
    _view.navigateToTransactionListPage();
  }
}
