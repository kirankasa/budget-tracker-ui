import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:budget_tracker/common/exception/CommonExceptions.dart';
import 'package:budget_tracker/transaction/Transaction.dart';
import 'package:budget_tracker/transaction/TransactionRepository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  static const transactions_url =
      'https://budget-tracker.cfapps.io/transactions';

  @override
  Future<List<Transaction>> retrieveTransactions() {
    return http.get(transactions_url).then((http.Response response) {
      final String jsonBody = response.body;
      final statusCode = response.statusCode;

      if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw new FetchDataException(
            "Error while retriveing transactions [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
      }
      final List transactions = JSON.decode(response.body);
      return transactions
          .map((transaction) => new Transaction.fromJson(transaction))
          .toList();
    });
  }

  @override
  Future<Transaction> retrieveTransactionDetails(int transactionId) {
    return http
        .get(transactions_url + "/" + transactionId.toString())
        .then((http.Response response) {
      final String jsonBody = response.body;
      final statusCode = response.statusCode;

      if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw new FetchDataException(
            "Error while retriveing transaction details [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
      }
      var transactionJson = JSON.decode(response.body);
      return new Transaction.fromJson(transactionJson);
    });
  }

  @override
  Future<Transaction> saveTransaction(Transaction transaction) {
    String requestJson = JSON.encode(transaction);
    return http.post(transactions_url, body: requestJson, headers: {
      'content-type': 'application/json'
    }).then((http.Response response) {
      final String jsonBody = response.body;
      final statusCode = response.statusCode;
      if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw new FetchDataException(
            "Error while saving transaction details [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
      }
      var transactionJson = JSON.decode(response.body);
      return new Transaction.fromJson(transactionJson);
    });
  }
}
