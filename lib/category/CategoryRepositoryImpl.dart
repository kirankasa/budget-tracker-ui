import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:budget_tracker/common/exception/CommonExceptions.dart';
import 'package:budget_tracker/category/Category.dart';
import 'package:budget_tracker/category/CategoryRepository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  static const categories_url =
      'https://budget-tracker.cfapps.io/transactions/categories';

  @override
  Future<List<TransactionCategory>> retrieveTransactionCategories() {
    return http.get(categories_url).then((http.Response response) {
      final String jsonBody = response.body;
      final statusCode = response.statusCode;

      if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw new FetchDataException(
            "Error while retriveing categories [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
      }
      final List categories = JSON.decode(response.body);
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
      var categoryJson = JSON.decode(response.body);
      return new TransactionCategory.fromJson(categoryJson);
    });
  }

  @override
  Future<TransactionCategory> saveTransactionCategory(
      TransactionCategory transactionCategory) {
    String requestJson = JSON.encode(transactionCategory);
    return http.post(categories_url, body: requestJson, headers: {
      'content-type': 'application/json'
    }).then((http.Response response) {
      final String jsonBody = response.body;
      final statusCode = response.statusCode;
      if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw new FetchDataException(
            "Error while saving transaction category details [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
      }
      var categoryJson = JSON.decode(response.body);
      return new TransactionCategory.fromJson(categoryJson);
    });
  }

  @override
  Future<TransactionCategory> updateTransactionCategory(
      TransactionCategory transactionCategory) {
    String requestJson = JSON.encode(transactionCategory);
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
      var categoryJson = JSON.decode(response.body);
      return new TransactionCategory.fromJson(categoryJson);
    });
  }
}
