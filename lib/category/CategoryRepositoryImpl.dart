import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:budget_tracker/common/exception/CommonExceptions.dart';
import 'package:budget_tracker/category/Category.dart';
import 'package:budget_tracker/category/CategoryRepository.dart';
import 'package:budget_tracker/common/constants.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  @override
  Future<List<TransactionCategory>> retrieveTransactionCategories() {
    return http.get(
      categories_url,
      headers: {HttpHeaders.AUTHORIZATION: "Basic your_api_token_here"},
    ).then((http.Response response) {
      final String jsonBody = response.body;
      final statusCode = response.statusCode;

      if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw new FetchDataException(
            "Error while retriveing categories [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
      }
      final List categories = json.decode(response.body);
      return categories
          .map((category) => new TransactionCategory.fromJson(category))
          .toList();
    });
  }

  @override
  Future<TransactionCategory> retrieveTransactionCategoryDetails(int id) {
    return http
        .get(categories_url + "/" + id.toString())
        .then((http.Response response) {
      final String jsonBody = response.body;
      final statusCode = response.statusCode;

      if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw new FetchDataException(
            "Error while retriveing Transaction category details[StatusCode:$statusCode, Error:${response.reasonPhrase}]");
      }
      var categoryJson = json.decode(response.body);
      return new TransactionCategory.fromJson(categoryJson);
    });
  }

  @override
  Future<TransactionCategory> saveTransactionCategory(
      TransactionCategory transactionCategory) {
    String requestJson = json.encode(transactionCategory);
    return http.post(categories_url, body: requestJson, headers: {
      'content-type': 'application/json'
    }).then((http.Response response) {
      final String jsonBody = response.body;
      final statusCode = response.statusCode;
      if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw new FetchDataException(
            "Error while saving transaction category details [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
      }
      var categoryJson = json.decode(response.body);
      return new TransactionCategory.fromJson(categoryJson);
    });
  }

  @override
  Future<TransactionCategory> updateTransactionCategory(
      TransactionCategory transactionCategory) {
    String requestJson = json.encode(transactionCategory);
    return http.put(categories_url + "/" + transactionCategory.id.toString(),
        body: requestJson,
        headers: {
          'content-type': 'application/json'
        }).then((http.Response response) {
      final String jsonBody = response.body;
      final statusCode = response.statusCode;
      if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw new FetchDataException(
            "Error while saving transaction category details [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
      }
      var categoryJson = json.decode(response.body);
      return new TransactionCategory.fromJson(categoryJson);
    });
  }
}
