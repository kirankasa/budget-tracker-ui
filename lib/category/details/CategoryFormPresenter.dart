import 'package:budget_tracker/category/Category.dart';
import 'package:budget_tracker/category/CategoryRepository.dart';
import 'package:budget_tracker/category/details/CategoryFormViewContract.dart';
import 'package:budget_tracker/common/di/injection.dart';

class CategoryFormPresenter {
  CategoryFormViewContract _view;
  CategoryRepository _repository;

  CategoryFormPresenter(this._view) {
    _repository = new Injector().categoryRepository;
  }

  void saveTransactionCategory(TransactionCategory transactionCategory) {
    assert(_view != null);

    _repository
        .saveTransactionCategory(transactionCategory)
        .then((category) => _view.navigateToCategoriesListPage())
        .catchError((onError) {
      _view.showError();
    });
  }
}
