import 'package:budget_tracker/category/CategoryRepository.dart';
import 'package:budget_tracker/common/di/injection.dart';
import 'package:budget_tracker/category/Category.dart';

abstract class CategoryDetailsViewContract {
  void showCategory(TransactionCategory category);

  void showError();
}

class CategoryDetailsPresenter {
  CategoryDetailsViewContract _view;
  CategoryRepository _repository;

  CategoryDetailsPresenter(this._view) {
    _repository = Injector().categoryRepository;
  }

  void loadTransactionDetails(String categoryId) {
    assert(_view != null);

    _repository
        .retrieveTransactionCategoryDetails(categoryId)
        .then((category) => _view.showCategory(category))
        .catchError((onError) {
      _view.showError();
    });
  }
}
