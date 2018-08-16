import 'package:budget_tracker/feedback/FeedbackRepository.dart';
import 'package:budget_tracker/feedback/FeedbackRepositoryImpl.dart';
import 'package:budget_tracker/user/UserRepository.dart';
import 'package:budget_tracker/user/UserRepositoryImpl.dart';
import 'package:budget_tracker/transaction/TransactionRepository.dart';
import 'package:budget_tracker/transaction/TransactionRepositoryImpl.dart';
import 'package:budget_tracker/category/CategoryRepository.dart';
import 'package:budget_tracker/category/CategoryRepositoryImpl.dart';

class Injector {
  static final Injector _singleton = Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  TransactionRepository get transactionRepository {
    return TransactionRepositoryImpl();
  }

  CategoryRepository get categoryRepository {
    return CategoryRepositoryImpl();
  }

  UserRepository get userRepository {
    return UserRepositoryImpl();
  }

  FeedbackRepository get feedbackRepository {
    return FeedbackRepositoryImpl();
  }
}
