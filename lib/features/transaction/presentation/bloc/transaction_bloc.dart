/* Flutter Imports */
import 'package:flutter/material.dart';

/* Package Imports */
import 'package:flutter_bloc/flutter_bloc.dart';

/* Project Imports */
import 'package:union/features/transaction/domain/usecases/transaction_get_transactions.dart';
import 'package:union/features/transaction/domain/usecases/transaction_get_transaction.dart';
import 'package:union/features/transaction/domain/usecases/transaction_get_by_group.dart';
import 'package:union/features/transaction/domain/entities/transaction_entity.dart';
import 'package:union/features/transaction/domain/usecases/transaction_create.dart';
import 'package:union/features/transaction/domain/usecases/transaction_delete.dart';
import 'package:union/features/transaction/domain/usecases/transaction_update.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionCreate _transactionCreate;
  final TransactionUpdate _transactionUpdate;
  final TransactionDelete _transactionDelete;
  final TransactionGetTransaction _transactionGetTransaction;
  final TransactionGetTransactions _transactionGetTransactions;
  final TransactionGetByGroup _transactionGetByGroup;

  TransactionBloc({
    required TransactionCreate transactionCreate,
    required TransactionUpdate transactionUpdate,
    required TransactionDelete transactionDelete,
    required TransactionGetTransaction transactionGetTransaction,
    required TransactionGetTransactions transactionGetTransactions,
    required TransactionGetByGroup transactionGetByGroup,
  })  : _transactionCreate = transactionCreate,
        _transactionUpdate = transactionUpdate,
        _transactionDelete = transactionDelete,
        _transactionGetTransaction = transactionGetTransaction,
        _transactionGetTransactions = transactionGetTransactions,
        _transactionGetByGroup = transactionGetByGroup,
        super(TransactionInitialState()) {
    on<TransactionEvent>((event, emit) => emit(TransactionLoadingState()));
    on<TransactionCreateEvent>(_createTransaction);
    on<TransactionUpdateEvent>(_updateTransaction);
    on<TransactionDeleteEvent>(_deleteTransaction);
    on<TransactionGetEvent>(_getTransaction);
    on<TransactionsGetEvent>(_getTransactions);
    on<TransactionsGetByGroupEvent>(_getTransactionsByGroup);
  }

  void _createTransaction(
    TransactionCreateEvent event,
    Emitter<TransactionState> emit,
  ) async {
    final response = await _transactionCreate(event.transaction);
    response.fold(
      (failure) => emit(TransactionErrorState(failure.message)),
      (transactionId) => emit(TransactionSuccessState(transactionId)),
    );
  }

  void _updateTransaction(
    TransactionUpdateEvent event,
    Emitter<TransactionState> emit,
  ) async {
    final response = await _transactionUpdate(event.transaction);
    response.fold(
      (failure) => emit(TransactionErrorState(failure.message)),
      (_) => emit(TransactionSuccessState(event.transaction.id)),
    );
  }

  void _deleteTransaction(
    TransactionDeleteEvent event,
    Emitter<TransactionState> emit,
  ) async {
    final response = await _transactionDelete(event.transactionId);
    response.fold(
      (failure) => emit(TransactionErrorState(failure.message)),
      (_) => emit(TransactionSuccessState(event.transactionId)),
    );
  }

  void _getTransaction(
    TransactionGetEvent event,
    Emitter<TransactionState> emit,
  ) async {
    final response = await _transactionGetTransaction(event.transactionId);
    response.fold(
      (failure) => emit(TransactionErrorState(failure.message)),
      (transaction) => emit(TransactionSuccessGetTransactionState(transaction)),
    );
  }

  void _getTransactions(
    TransactionsGetEvent event,
    Emitter<TransactionState> emit,
  ) async {
    final response = await _transactionGetTransactions(event.userId);
    response.fold(
      (failure) => emit(TransactionErrorState(failure.message)),
      (transactions) =>
          emit(TransactionSuccessGetTransactionsState(transactions)),
    );
  }

  void _getTransactionsByGroup(
    TransactionsGetByGroupEvent event,
    Emitter<TransactionState> emit,
  ) async {
    final response = await _transactionGetByGroup(event.groupId);
    response.fold(
      (failure) => emit(TransactionErrorState(failure.message)),
      (transactions) =>
          emit(TransactionSuccessGetTransactionsState(transactions)),
    );
  }
}
