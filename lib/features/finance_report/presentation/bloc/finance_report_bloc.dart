/* Flutter Imports */
import 'package:flutter/material.dart';

/* Package Imports */
import 'package:union/features/finance_report/domain/usecases/finance_report_get_income_and_expense.dart';
import 'package:union/features/finance_report/domain/usecases/finance_report_get_expense_by_month.dart';
import 'package:union/features/finance_report/domain/usecases/finance_report_add_fixed_income.dart';
import 'package:union/features/finance_report/domain/usecases/finance_report_get_fixed_income.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/* Project Imports */

part 'finance_report_event.dart';
part 'finance_report_state.dart';

class FinanceReportBloc extends Bloc<FinanceReportEvent, FinanceReportState> {
  final FinanceReportAddFixedIncome _financeReportAddFixedIncome;
  final FinanceReportGetFixedIncome _financeReportGetFixedIncome;
  final FinanceReportGetExpenseByMonth _financeReportGetExpenseByMonth;
  final FinanceReportGetIncomeAndExpense _financeReportGetIncomeAndExpense;

  FinanceReportBloc({
    required FinanceReportAddFixedIncome financeReportAddFixedIncome,
    required FinanceReportGetFixedIncome financeReportGetFixedIncome,
    required FinanceReportGetExpenseByMonth financeReportGetExpenseByMonth,
    required FinanceReportGetIncomeAndExpense financeReportGetIncomeAndExpense,
  })  : _financeReportAddFixedIncome = financeReportAddFixedIncome,
        _financeReportGetFixedIncome = financeReportGetFixedIncome,
        _financeReportGetExpenseByMonth = financeReportGetExpenseByMonth,
        _financeReportGetIncomeAndExpense = financeReportGetIncomeAndExpense,
        super(FinanceReportInitial()) {
    on<FinanceReportEvent>((event, emit) {});
    on<FinanceReportAddFixedIncomeEvent>(_addFixedIncome);
    on<FinanceReportGetFixedIncomeEvent>(_getFixedIncome);
    on<FinanceReportGetExpenseByMonthEvent>(_getExpenseByMonth);
    on<FinanceReportGetIncomeAndExpenseEvent>(_getIncomeAndExpense);
  }

  void _addFixedIncome(
    FinanceReportAddFixedIncomeEvent event,
    Emitter<FinanceReportState> emit,
  ) async {
    final result = await _financeReportAddFixedIncome(event.params);
    result.fold(
      (failure) => emit(FinanceReportError(failure.message)),
      (success) => emit(FinanceReportFixedIncome(success)),
    );
  }

  void _getFixedIncome(
    FinanceReportGetFixedIncomeEvent event,
    Emitter<FinanceReportState> emit,
  ) async {
    final result = await _financeReportGetFixedIncome(event.userId);
    result.fold(
      (failure) => emit(FinanceReportError(failure.message)),
      (success) => emit(FinanceReportFixedIncome(success)),
    );
  }

  void _getExpenseByMonth(
    FinanceReportGetExpenseByMonthEvent event,
    Emitter<FinanceReportState> emit,
  ) async {
    final result = await _financeReportGetExpenseByMonth(event.userId);
    result.fold(
      (failure) => emit(FinanceReportError(failure.message)),
      (success) => emit(FinanceReportSuccessGetExpenseByMonth(success)),
    );
  }

  void _getIncomeAndExpense(
    FinanceReportGetIncomeAndExpenseEvent event,
    Emitter<FinanceReportState> emit,
  ) async {
    final result = await _financeReportGetIncomeAndExpense(event.userId);
    result.fold(
      (failure) => emit(FinanceReportError(failure.message)),
      (success) => emit(FinanceReportSuccessGetIncomeAndExpense(success)),
    );
  }
}
