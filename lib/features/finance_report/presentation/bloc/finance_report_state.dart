part of 'finance_report_bloc.dart';

@immutable
sealed class FinanceReportState {
  const FinanceReportState();
}

final class FinanceReportInitial extends FinanceReportState {}

final class FinanceReportLoading extends FinanceReportState {}

final class FinanceReportError extends FinanceReportState {
  final String message;

  const FinanceReportError(this.message);
}

final class FinanceReportFixedIncome extends FinanceReportState {
  final double value;

  const FinanceReportFixedIncome(this.value);
}

final class FinanceReportSuccess extends FinanceReportState {
  final double income;
  final double expense;

  const FinanceReportSuccess(this.income, this.expense);
}

final class FinanceReportSuccessGetExpenseByMonth extends FinanceReportState {
  final List<double> expenseByMonth;

  const FinanceReportSuccessGetExpenseByMonth(this.expenseByMonth);
}

final class FinanceReportSuccessGetIncomeAndExpense extends FinanceReportState {
  final List<double> incomeAndExpense;

  const FinanceReportSuccessGetIncomeAndExpense(this.incomeAndExpense);
}
