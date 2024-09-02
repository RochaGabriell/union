part of 'finance_report_bloc.dart';

@immutable
sealed class FinanceReportEvent {}

final class FinanceReportAddFixedIncomeEvent extends FinanceReportEvent {
  final FinanceReportAddFixedIncomeParams params;

  FinanceReportAddFixedIncomeEvent({required this.params});
}

final class FinanceReportGetFixedIncomeEvent extends FinanceReportEvent {
  final String userId;

  FinanceReportGetFixedIncomeEvent({required this.userId});
}

final class FinanceReportGetExpenseByMonthEvent extends FinanceReportEvent {
  final String userId;

  FinanceReportGetExpenseByMonthEvent({required this.userId});
}

final class FinanceReportGetIncomeAndExpenseEvent extends FinanceReportEvent {
  final String userId;

  FinanceReportGetIncomeAndExpenseEvent({required this.userId});
}
