import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:budget_tracker/common/SharedPreferencesHelper.dart';
import 'package:budget_tracker/transaction/AmountPerCategory.dart';
import 'package:http/http.dart' as http;

import 'package:budget_tracker/common/exception/CommonExceptions.dart';
import 'package:budget_tracker/transaction/Transaction.dart';
import 'package:budget_tracker/transaction/TransactionRepository.dart';
import 'package:budget_tracker/common/constants.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  @override
  Future<List<Transaction>> retrieveTransactions() async {
    String _token = await SharedPreferencesHelper.getTokenValue();
    var response = await http.get(transactions_url,
        headers: {HttpHeaders.authorizationHeader: _token});
    final String jsonBody = response.body;
    final statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw FetchDataException(
          "Error while retriveing transactions [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
    }
    final List transactions = json.decode(response.body);
    return transactions
        .map((transaction) => Transaction.fromJson(transaction))
        .toList();
  }

  @override
  Future<Transaction> retrieveTransactionDetails(String transactionId) async {
    String _token = await SharedPreferencesHelper.getTokenValue();
    var response = await http.get(
        transactions_url + "/" + transactionId.toString(),
        headers: {HttpHeaders.authorizationHeader: _token});
    final String jsonBody = response.body;
    final statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw FetchDataException(
          "Error while retriveing transaction details [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
    }
    var transactionJson = json.decode(response.body);
    return Transaction.fromJson(transactionJson);
  }

  @override
  Future<Transaction> saveTransaction(Transaction transaction) async {
    String _token = await SharedPreferencesHelper.getTokenValue();
    String requestJson = json.encode(transaction);
    var response =
        await http.post(transactions_url, body: requestJson, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: _token
    });
    final String jsonBody = response.body;
    final statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw FetchDataException(
          "Error while saving transaction details [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
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
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: _token
        });
    final String jsonBody = response.body;
    final statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw FetchDataException(
          "Error while saving transaction details [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
    }
    var transactionJson = json.decode(response.body);
    return Transaction.fromJson(transactionJson);
  }

  @override
  Future<Null> deleteTransaction(String transactionId) async {
    String _token = await SharedPreferencesHelper.getTokenValue();
    var response = await http
        .delete(transactions_url + "/" + transactionId.toString(), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: _token
    });
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300) {
      throw FetchDataException(
          "Error while deleting transaction details [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
    }
    return null;
  }

  @override
  Future<List<AmountPerCategory>> retrieveAmountPerCategory(
      String monthAndYear, String transactionType) async {
    String _token = await SharedPreferencesHelper.getTokenValue();
    var queryParameters = {
      "monthAndYear": monthAndYear,
      "transactionType": transactionType
    };
    var uri = Uri(scheme: "http",
        host: "10.216.72.113",
        port: 8080,
        path: "transactions/amountPerCategory",
        queryParameters: queryParameters);
    var response =
        await http.get(uri, headers: {HttpHeaders.authorizationHeader: _token});
    final String jsonBody = response.body;
    final statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw FetchDataException(
          "Error while retrieving Amount Per Category [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
    }
    final List amountPerCategories = json.decode(response.body);
    return amountPerCategories
        .map((amountPerCategory) =>
            AmountPerCategory.fromJson(amountPerCategory))
        .toList();
  }
}
