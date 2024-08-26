/* Package Imports */
import 'package:fpdart/fpdart.dart';

/* Project Imports */
import 'package:union/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:union/core/usecase/usecase.dart';
import 'package:union/core/errors/failures.dart';

class TransactionDelete implements UseCase<void, String> {
  final TransactionRepository _transactionRepository;

  TransactionDelete(this._transactionRepository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await _transactionRepository.deleteTransaction(
      transactionId: params,
    );
  }
}
