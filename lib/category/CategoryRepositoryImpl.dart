import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:budget_tracker/common/SharedPreferencesHelper.dart';
import 'package:http/http.dart' as http;

import 'package:budget_tracker/common/exception/CommonExceptions.dart';
import 'package:budget_tracker/category/Category.dart';
import 'package:budget_tracker/category/CategoryRepository.dart';
import 'package:budget_tracker/common/constants.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  @override
  Future<List<TransactionCategory>> retrieveTransactionCategories() async {
    String _token = await SharedPreferencesHelper.getTokenValue();
    var response = await http.get(
      categories_url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: _token
      },
    );
    final String jsonBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw FetchDataException(
          "Error while retriveing categories [StatusCode:$statusCode, Error:${response
              .reasonPhrase}]");
    }
    final List categories = json.decode(response.body);
    return categories
        .map((category) => TransactionCategory.fromJson(category))
        .toList();
  }

  @override
  Future<TransactionCategory> retrieveTransactionCategoryDetails(String id) async {
    String _token = await SharedPreferencesHelper.getTokenValue();
    var response = await http.get(categories_url + "/" + id.toString(),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: _token
        });

    final String jsonBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw FetchDataException(
          "Error while retriveing Transaction category details[StatusCode:$statusCode, Error:${response
              .reasonPhrase}]");
    }
    var categoryJson = json.decode(response.body);
    return TransactionCategory.fromJson(categoryJson);
  }

  @override
  Future<TransactionCategory> saveTransactionCategory(
      TransactionCategory transactionCategory) async {
    String _token = await SharedPreferencesHelper.getTokenValue();
    String requestJson = json.encode(transactionCategory);
    var response = await http.post(categories_url, body: requestJson, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: _token
    });
    final String jsonBody = response.body;
    final statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw FetchDataException(
          "Error while saving transaction category details [StatusCode:$statusCode, Error:${response
              .reasonPhrase}]");
    }
    var categoryJson = json.decode(response.body);
    return TransactionCategory.fromJson(categoryJson);
  }

  @override
  Future<TransactionCategory> updateTransactionCategory(
      TransactionCategory transactionCategory) async {
    String _token = await SharedPreferencesHelper.getTokenValue();
    String requestJson = json.encode(transactionCategory);
    var response = await http.put(
        categories_url + "/" + transactionCategory.id.toString(),
        body: requestJson,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: _token
        });
    final String jsonBody = response.body;
    final statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw FetchDataException(
          "Error while saving transaction category details [StatusCode:$statusCode, Error:${response
              .reasonPhrase}]");
    }
    var categoryJson = json.decode(response.body);
    return TransactionCategory.fromJson(categoryJson);
  }
}
