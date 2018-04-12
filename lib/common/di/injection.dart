import 'package:budget_tracker/user/UserRepository.dart';
import 'package:budget_tracker/user/UserRepositoryImpl.dart';
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

  UserRepository get userRepository {
    return new UserRepositoryImpl();
  }
}
