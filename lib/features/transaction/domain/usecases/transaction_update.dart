/* Package Imports */
import 'package:fpdart/fpdart.dart';

/* Project Imports */
import 'package:union/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:union/features/transaction/domain/entities/transaction_entity.dart';
import 'package:union/core/usecase/usecase.dart';
import 'package:union/core/errors/failures.dart';

class TransactionUpdate implements UseCase<void, TransactionEntity> {
  final TransactionRepository _transactionRepository;

  TransactionUpdate(this._transactionRepository);

  @override
  Future<Either<Failure, void>> call(TransactionEntity params) async {
    return await _transactionRepository.updateTransaction(transaction: params);
  }
}
