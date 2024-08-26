/* Package Imports */
import 'package:union/features/transaction/data/repositories/transaction_repository_impl.dart';
import 'package:union/features/transaction/domain/usecases/transaction_get_transactions.dart';
import 'package:union/features/transaction/domain/usecases/transaction_get_transaction.dart';
import 'package:union/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:union/features/transaction/domain/usecases/transaction_get_by_group.dart';
import 'package:union/features/transaction/domain/usecases/transaction_update.dart';
import 'package:union/features/transaction/domain/usecases/transaction_delete.dart';
import 'package:union/features/transaction/domain/usecases/transaction_create.dart';
import 'package:union/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:union/features/transaction/data/datasources/remote.dart';
import 'package:union/core/utils/injections.dart';

void initTransactionInjections() {
  getIt
    ..registerFactory<TransactionRemoteDataSource>(() {
      return TransactionRemoteDataSourceImpl(getIt());
    })
    // Repositories
    ..registerFactory<TransactionRepository>(() {
      return TransactionRepositoryImpl(
        getIt(),
        getIt(),
      );
    })
    // Use cases
    ..registerFactory(() => TransactionCreate(getIt()))
    ..registerFactory(() => TransactionUpdate(getIt()))
    ..registerFactory(() => TransactionDelete(getIt()))
    ..registerFactory(() => TransactionGetTransaction(getIt()))
    ..registerFactory(() => TransactionGetTransactions(getIt()))
    ..registerFactory(() => TransactionGetByGroup(getIt()))
    // Bloc
    ..registerLazySingleton(() {
      return TransactionBloc(
        transactionCreate: getIt(),
        transactionUpdate: getIt(),
        transactionDelete: getIt(),
        transactionGetByGroup: getIt(),
        transactionGetTransaction: getIt(),
        transactionGetTransactions: getIt(),
      );
    });
}
