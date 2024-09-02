/* Package Imports */
import 'package:fpdart/fpdart.dart';

/* Project Imports */
import 'package:union/features/finance_report/domain/repositories/finance_report_repository.dart';
import 'package:union/features/finance_report/data/datasources/remote.dart';
import 'package:union/core/network/connection_checker.dart';
import 'package:union/core/constants/constants.dart';
import 'package:union/core/errors/exceptions.dart';
import 'package:union/core/errors/failures.dart';

class FinanceReportRepositoryImpl implements FinanceReportRepository {
  final FinanceReportRemoteDataSource _financeReportRemoteDataSource;
  final ConnectionChecker _connectionChecker;

  FinanceReportRepositoryImpl(
    this._financeReportRemoteDataSource,
    this._connectionChecker,
  );

  Future<bool> _isConnected() async {
    return await _connectionChecker.connected;
  }

  Future<Either<Failure, T>> _performRemoteOperation<T>(
    Future<T> Function() operation,
  ) async {
    if (!await _isConnected()) {
      return left(Failure(Constants.noConnectionMessage));
    }
    try {
      final result = await operation();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, double>> addFixedIncome({
    required String userId,
    required double value,
  }) async {
    return await _performRemoteOperation(() async {
      return await _financeReportRemoteDataSource.addFixedIncome(
        userId: userId,
        value: value,
      );
    });
  }

  @override
  Future<Either<Failure, double>> getFixedIncomeUser({
    required String userId,
  }) async {
    return await _performRemoteOperation(() async {
      return await _financeReportRemoteDataSource.getFixedIncomeUser(
        userId: userId,
      );
    });
  }

  @override
  Future<Either<Failure, List<double>>> getIncomeAndExpense({
    required String userId,
  }) async {
    return await _performRemoteOperation(() async {
      return await _financeReportRemoteDataSource.getIncomeAndExpense(
        userId: userId,
      );
    });
  }

  @override
  Future<Either<Failure, List<double>>> getExpenseByMonth({
    required String userId,
  }) async {
    return await _performRemoteOperation(() async {
      return await _financeReportRemoteDataSource.getExpenseByMonth(
        userId: userId,
      );
    });
  }
}
