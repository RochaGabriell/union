/* Package Imports */
import 'package:fpdart/fpdart.dart';

/* Project Imports */
import 'package:union/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:union/features/transaction/domain/entities/transaction_entity.dart';
import 'package:union/core/usecase/usecase.dart';
import 'package:union/core/errors/failures.dart';

class TransactionCreate implements UseCase<String, TransactionEntity> {
  final TransactionRepository _transactionRepository;

  TransactionCreate(this._transactionRepository);

  @override
  Future<Either<Failure, String>> call(TransactionEntity params) async {
    return await _transactionRepository.createTransaction(transaction: params);
  }
}
