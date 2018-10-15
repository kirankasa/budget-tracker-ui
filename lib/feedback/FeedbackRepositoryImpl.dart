import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:budget_tracker/common/SharedPreferencesHelper.dart';
import 'package:budget_tracker/feedback/Feedback.dart';
import 'package:budget_tracker/feedback/FeedbackRepository.dart';
import 'package:http/http.dart' show Client;

import 'package:budget_tracker/common/exception/CommonExceptions.dart';
import 'package:budget_tracker/common/constants.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {

  Client client = Client();

  @override
  Future<String> feedback(ExpenseFeedback feedback) async {
    String _token = await SharedPreferencesHelper.getTokenValue();
    String requestJson = json.encode(feedback);
    var response = await client.post(feedback_url, body: requestJson, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: _token
    });
    final String jsonBody = response.body;
    final statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw FetchDataException(
          "Error while posting feedback [StatusCode:$statusCode, Error:${response
              .reasonPhrase}]");
    }
    return response.body;
  }
}
