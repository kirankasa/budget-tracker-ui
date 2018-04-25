import 'dart:async';

import 'package:budget_tracker/feedback/Feedback.dart';
import 'package:budget_tracker/user/AuthenticationRequest.dart';
import 'package:budget_tracker/user/AuthenticationResponse.dart';
import 'package:budget_tracker/user/User.dart';

abstract class FeedbackRepository {
  Future<String> feedback(ExpenseFeedback feedback);
}
