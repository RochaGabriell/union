/* Package Imports */
import 'package:fpdart/fpdart.dart';

/* Project Imports */
import 'package:union/core/errors/failures.dart';

abstract interface class FinanceReportRepository {
  Future<Either<Failure, double>> getFixedIncomeUser({required String userId});

  Future<Either<Failure, double>> addFixedIncome({
    required String userId,
    required double value,
  });

  Future<Either<Failure, List<double>>> getIncomeAndExpense({required String userId});

  Future<Either<Failure, List<double>>> getExpenseByMonth({required String userId});
}