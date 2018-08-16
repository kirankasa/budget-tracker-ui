import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:budget_tracker/common/SharedPreferencesHelper.dart';
import 'package:http/http.dart' as http;

import 'package:budget_tracker/common/exception/CommonExceptions.dart';
import 'package:budget_tracker/transaction/Transaction.dart';
import 'package:budget_tracker/transaction/TransactionRepository.dart';
import 'package:budget_tracker/common/constants.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  @override
  Future<List<Transaction>> retrieveTransactions() async {
    String _token = await SharedPreferencesHelper.getTokenValue();
    var response = await http
        .get(transactions_url, headers: {HttpHeaders.AUTHORIZATION: _token});
    final String jsonBody = response.body;
    final statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw FetchDataException(
          "Error while retriveing transactions [StatusCode:$statusCode, Error:${response
              .reasonPhrase}]");
    }
    final List transactions = json.decode(response.body);
    return transactions
        .map((transaction) => Transaction.fromJson(transaction))
        .toList();
  }

  @override
  Future<Transaction> retrieveTransactionDetails(int transactionId) async {
    String _token = await SharedPreferencesHelper.getTokenValue();
    var response = await http.get(
        transactions_url + "/" + transactionId.toString(),
        headers: {HttpHeaders.AUTHORIZATION: _token});
    final String jsonBody = response.body;
    final statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw FetchDataException(
          "Error while retriveing transaction details [StatusCode:$statusCode, Error:${response
              .reasonPhrase}]");
    }
    var transactionJson = json.decode(response.body);
    return Transaction.fromJson(transactionJson);
  }

  @override
  Future<Transaction> saveTransaction(Transaction transaction) async {
    String _token = await SharedPreferencesHelper.getTokenValue();
    String requestJson = json.encode(transaction);
    var response = await http.post(transactions_url,
        body: requestJson,
        headers: {
          HttpHeaders.CONTENT_TYPE: 'application/json',
          HttpHeaders.AUTHORIZATION: _token
        });
    final String jsonBody = response.body;
    final statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw FetchDataException(
          "Error while saving transaction details [StatusCode:$statusCode, Error:${response
              .reasonPhrase}]");
    }
    var transactionJson = json.decode(response.body);
    return Transaction.fromJson(transactionJson);
  }

  @override
  Future<Transaction> updateTransaction(Transaction transaction) async {
    String _token = await SharedPreferencesHelper.getTokenValue();
    String requestJson = json.encode(transaction);
    var response = await http.put(
        transactions_url + "/" + transaction.id.toString(),
        body: requestJson,
        headers: {
          HttpHeaders.CONTENT_TYPE: 'application/json',
          HttpHeaders.AUTHORIZATION: _token
        });
    final String jsonBody = response.body;
    final statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw FetchDataException(
          "Error while saving transaction details [StatusCode:$statusCode, Error:${response
              .reasonPhrase}]");
    }
    var transactionJson = json.decode(response.body);
    return Transaction.fromJson(transactionJson);
  }

  @override
  Future<Null> deleteTransaction(int transactionId) async {
    String _token = await SharedPreferencesHelper.getTokenValue();
    var response = await http
        .delete(transactions_url + "/" + transactionId.toString(), headers: {
      HttpHeaders.CONTENT_TYPE: 'application/json',
      HttpHeaders.AUTHORIZATION: _token
    });
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300) {
      throw FetchDataException(
          "Error while deleting transaction details [StatusCode:$statusCode, Error:${response
              .reasonPhrase}]");
    }
    return null;
  }
}
