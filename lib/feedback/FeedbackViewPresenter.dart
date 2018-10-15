import 'package:budget_tracker/feedback/Feedback.dart';
import 'package:budget_tracker/feedback/FeedbackRepository.dart';
import 'package:budget_tracker/common/di/injection.dart';

abstract class FeedbackViewContract {
  void success();
  void showError();
}

class FeedbackViewPresenter {
  FeedbackViewContract _view;
  FeedbackRepository _repository;
  FeedbackViewPresenter(this._view) {
    _repository =  Injector().feedbackRepository;
  }

  void feedback(ExpenseFeedback feedback) {
    assert(_view != null);
    _repository.feedback(feedback).then((String response) {
      _view.success();
    }).catchError((onError) {
      _view.showError();
    });
  }
}
