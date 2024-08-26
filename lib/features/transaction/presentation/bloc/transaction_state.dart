part of 'transaction_bloc.dart';

@immutable
sealed class TransactionState {
  const TransactionState();
}

final class TransactionInitialState extends TransactionState {}

final class TransactionLoadingState extends TransactionState {}

final class TransactionErrorState extends TransactionState {
  final String message;

  const TransactionErrorState(this.message);
}

final class TransactionSuccessState extends TransactionState {
  final String? transactionId;

  const TransactionSuccessState(this.transactionId);
}

final class TransactionSuccessGetTransactionState extends TransactionState {
  final TransactionEntity transaction;

  const TransactionSuccessGetTransactionState(this.transaction);
}

final class TransactionSuccessGetTransactionsState extends TransactionState {
  final List<TransactionEntity> transactions;

  const TransactionSuccessGetTransactionsState(this.transactions);
}

final class TransactionSuccessGetTransactionsByGroupState
    extends TransactionState {
  final List<TransactionEntity> transactions;

  const TransactionSuccessGetTransactionsByGroupState(this.transactions);
}
