/* Package Imports */
import 'package:fpdart/fpdart.dart';

/* Project Imports */
import 'package:union/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:union/features/transaction/domain/entities/transaction_entity.dart';
import 'package:union/core/usecase/usecase.dart';
import 'package:union/core/errors/failures.dart';

class TransactionGetTransactions
    implements UseCase<List<TransactionEntity>, String> {
  final TransactionRepository _transactionRepository;
  
  TransactionGetTransactions(this._transactionRepository);

  @override
  Future<Either<Failure, List<TransactionEntity>>> call(String params) async {
    return await _transactionRepository.getTransactions(userId: params);
  }
}
