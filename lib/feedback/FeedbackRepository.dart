import 'dart:async';

import 'package:budget_tracker/feedback/Feedback.dart';

abstract class FeedbackRepository {
  Future<String> feedback(ExpenseFeedback feedback);
}
