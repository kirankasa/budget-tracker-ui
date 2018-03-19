import 'package:budget_tracker/category/CategoryRepository.dart';
import 'package:budget_tracker/category/details/CategoryDetailsViewContract.dart';
import 'package:budget_tracker/common/di/injection.dart';

class CategoryDetailsPresenter{
  CategoryDetailsViewContract _view;
  CategoryRepository _repository;

  CategoryDetailsPresenter(this._view) {
    _repository = new Injector().categoryRepository;
  }

  void loadTransactionDetails(int categoryId) {
    assert(_view != null);

    _repository
        .retrieveTransactionCategoryDetails(categoryId)
        .then((category) => _view.showCategory(category))
        .catchError((onError) {
      _view.showError();
    });
  }
}