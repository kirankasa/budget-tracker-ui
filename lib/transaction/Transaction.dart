import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:budget_tracker/category/Category.dart';
import 'package:intl/intl.dart';

class Transaction {
  final int id;
  final String type;
  final TransactionCategory category;
  final double amount;
  final DateTime dateTime;
  final String note;

  Transaction(
      {this.id,
      this.type,
      this.category,
      this.amount,
      this.dateTime,
      this.note});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return new Transaction(
      id: json['id'],
      type: json['type'],
      amount: json['amount'],
      dateTime:  new DateFormat('yyyy-MM-dd').parse(json['date']),
      note: json['note'],
      category: new TransactionCategory.fromJson(json['category'])
    );
  }
}

Future<Transaction> retrieveTransactions() async {
  final response =
      await http.get('https://budget-tracker.cfapps.io/transactions');
  final json = JSON.decode(response.body);

  return new Transaction.fromJson(json);
}