/* Package Imports */
import 'package:fpdart/fpdart.dart';

/* Project Imports */
import 'package:union/features/transaction/domain/entities/transaction_entity.dart';
import 'package:union/core/errors/failures.dart';

abstract interface class TransactionRepository {
  Future<Either<Failure, String>> createTransaction({
    required TransactionEntity transaction,
  });

  Future<Either<Failure, void>> updateTransaction({
    required TransactionEntity transaction,
  });

  Future<Either<Failure, void>> deleteTransaction({
    required String transactionId,
  });

  Future<Either<Failure, TransactionEntity>> getTransaction({
    required String transactionId,
  });

  Future<Either<Failure, List<TransactionEntity>>> getTransactions({
    required String userId,
  });

  Future<Either<Failure, List<TransactionEntity>>> getTransactionsByGroup({
    required String groupId,
  });
}
