import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:budget_tracker/feedback/Feedback.dart';
import 'package:budget_tracker/feedback/FeedbackRepository.dart';
import 'package:http/http.dart' as http;

import 'package:budget_tracker/common/exception/CommonExceptions.dart';
import 'package:budget_tracker/common/constants.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {
  @override
  Future<String> feedback(ExpenseFeedback feedback) async {
    String requestJson = json.encode(feedback);
    var response = await http.post(feedback_url, body: requestJson, headers: {
      HttpHeaders.CONTENT_TYPE: 'application/json',
    });
    final String jsonBody = response.body;
    final statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw new FetchDataException(
          "Error while posting feedback [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
    }
    return response.body;
  }
}
