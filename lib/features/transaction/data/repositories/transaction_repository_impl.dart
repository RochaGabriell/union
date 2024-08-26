/* Package Imports */
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

/* Project Imports */
import 'package:union/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:union/features/transaction/domain/entities/transaction_entity.dart';
import 'package:union/features/transaction/data/datasources/remote.dart';
import 'package:union/features/transaction/data/models/transaction.dart';
import 'package:union/core/network/connection_checker.dart';
import 'package:union/core/constants/constants.dart';
import 'package:union/core/errors/exceptions.dart';
import 'package:union/core/errors/failures.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource _transactionRemoteDataSource;
  final ConnectionChecker _connectionChecker;

  TransactionRepositoryImpl(
    this._transactionRemoteDataSource,
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

  TransactionModel _mapEntityToModel(TransactionEntity transaction) {
    return TransactionModel(
      id: const Uuid().v4(),
      description: transaction.description,
      date: transaction.date,
      value: transaction.value,
      groupId: transaction.groupId,
      userId: transaction.userId,
      category: transaction.category,
      type: transaction.type,
    );
  }

  @override
  Future<Either<Failure, String>> createTransaction({
    required TransactionEntity transaction,
  }) async {
    return _performRemoteOperation(() async {
      final transactionModel = _mapEntityToModel(transaction);
      return await _transactionRemoteDataSource.createTransaction(
        transaction: transactionModel,
      );
    });
  }

  @override
  Future<Either<Failure, void>> updateTransaction({
    required TransactionEntity transaction,
  }) async {
    return _performRemoteOperation(() async {
      final transactionModel = _mapEntityToModel(transaction);
      await _transactionRemoteDataSource.updateTransaction(
        transaction: transactionModel,
      );
    });
  }

  @override
  Future<Either<Failure, void>> deleteTransaction({
    required String transactionId,
  }) async {
    return _performRemoteOperation(() async {
      await _transactionRemoteDataSource.deleteTransaction(
        transactionId: transactionId,
      );
    });
  }

  @override
  Future<Either<Failure, TransactionEntity>> getTransaction({
    required String transactionId,
  }) async {
    return _performRemoteOperation(() async {
      final transactionModel =
          await _transactionRemoteDataSource.getTransaction(
        transactionId: transactionId,
      );
      return TransactionEntity(
        id: transactionModel.id,
        description: transactionModel.description,
        date: transactionModel.date,
        value: transactionModel.value,
        groupId: transactionModel.groupId,
        userId: transactionModel.userId,
        category: transactionModel.category,
        type: transactionModel.type,
      );
    });
  }

  @override
  Future<Either<Failure, List<TransactionEntity>>> getTransactions({
    required String userId,
  }) async {
    return _performRemoteOperation(() async {
      final transactions = await _transactionRemoteDataSource.getTransactions(
        userId: userId,
      );
      return transactions.map((transaction) {
        return TransactionEntity(
          id: transaction.id,
          description: transaction.description,
          date: transaction.date,
          value: transaction.value,
          groupId: transaction.groupId,
          userId: transaction.userId,
          category: transaction.category,
          type: transaction.type,
        );
      }).toList();
    });
  }

  @override
  Future<Either<Failure, List<TransactionEntity>>> getTransactionsByGroup({
    required String groupId,
  }) async {
    return _performRemoteOperation(() async {
      final transactions =
          await _transactionRemoteDataSource.getTransactionsByGroup(
        groupId: groupId,
      );
      return transactions.map((transaction) {
        return TransactionEntity(
          id: transaction.id,
          description: transaction.description,
          date: transaction.date,
          value: transaction.value,
          groupId: transaction.groupId,
          userId: transaction.userId,
          category: transaction.category,
          type: transaction.type,
        );
      }).toList();
    });
  }
}
