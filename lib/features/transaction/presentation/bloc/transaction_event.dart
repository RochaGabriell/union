part of 'transaction_bloc.dart';

@immutable
sealed class TransactionEvent {}

final class TransactionCreateEvent extends TransactionEvent {
  final TransactionEntity transaction;

  TransactionCreateEvent({required this.transaction});
}

final class TransactionUpdateEvent extends TransactionEvent {
  final TransactionEntity transaction;

  TransactionUpdateEvent({required this.transaction});
}

final class TransactionDeleteEvent extends TransactionEvent {
  final String transactionId;

  TransactionDeleteEvent({required this.transactionId});
}

final class TransactionGetEvent extends TransactionEvent {
  final String transactionId;

  TransactionGetEvent({required this.transactionId});
}

final class TransactionsGetEvent extends TransactionEvent {
  final String userId;

  TransactionsGetEvent({required this.userId});
}

final class TransactionsGetByGroupEvent extends TransactionEvent {
  final String groupId;

  TransactionsGetByGroupEvent({required this.groupId});
}
