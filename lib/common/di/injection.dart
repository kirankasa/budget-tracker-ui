import 'package:budget_tracker/login/LoginRepository.dart';
import 'package:budget_tracker/login/LoginRepositoryImpl.dart';
import 'package:budget_tracker/transaction/TransactionRepository.dart';
import 'package:budget_tracker/transaction/TransactionRepositoryImpl.dart';
import 'package:budget_tracker/category/CategoryRepository.dart';
import 'package:budget_tracker/category/CategoryRepositoryImpl.dart';

class Injector {
  static final Injector _singleton = new Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  TransactionRepository get transactionRepository {
    return new TransactionRepositoryImpl();
  }

  CategoryRepository get categoryRepository {
    return new CategoryRepositoryImpl();
  }

  LoginRepository get loginRepository {
    return new LoginRepositoryImpl();
  }
}
