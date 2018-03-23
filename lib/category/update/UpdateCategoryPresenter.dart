import 'package:budget_tracker/category/Category.dart';
import 'package:budget_tracker/category/CategoryRepository.dart';
import 'package:budget_tracker/common/di/injection.dart';

abstract class UpdateCategoryViewContract {
  void navigateToCategoriesListPage();
  void showError();
}

class UpdateCategoryPresenter {
  UpdateCategoryViewContract _view;
  CategoryRepository _repository;

  UpdateCategoryPresenter(this._view) {
    _repository = new Injector().categoryRepository;
  }

  void updateTransactionCategory(TransactionCategory transactionCategory) {
    assert(_view != null);

    _repository
        .updateTransactionCategory(transactionCategory)
        .then((category) => _view.navigateToCategoriesListPage())
        .catchError((onError) {
      _view.showError();
    });
  }
}
