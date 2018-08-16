import 'package:budget_tracker/user/User.dart';
import 'package:budget_tracker/common/di/injection.dart';
import 'package:budget_tracker/user/UserRepository.dart';

abstract class SignUpViewContract {
  void navigateToLoginPage();

  void showError();
}

class SignUpViewPresenter {
  SignUpViewContract _view;
  UserRepository _repository;

  SignUpViewPresenter(this._view) {
    _repository = Injector().userRepository;
  }

  void register(User user) {
    assert(_view != null);
    _repository.register(user).then((User user) {
      _view.navigateToLoginPage();
    }).catchError((onError) {
      _view.showError();
    });
  }
}
