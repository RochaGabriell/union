/* Project Imports */
import 'package:union/features/finance_report/data/repositories/finance_report_repository_impl.dart';
import 'package:union/features/finance_report/domain/usecases/finance_report_add_fixed_income.dart';
import 'package:union/features/finance_report/domain/repositories/finance_report_repository.dart';
import 'package:union/features/finance_report/data/datasources/remote.dart';
import 'package:union/core/utils/injections.dart';
import 'package:union/features/finance_report/domain/usecases/finance_report_get_fixed_income.dart';
import 'package:union/features/finance_report/domain/usecases/finance_report_get_expense_by_month.dart';
import 'package:union/features/finance_report/domain/usecases/finance_report_get_income_and_expense.dart';
import 'package:union/features/finance_report/presentation/bloc/finance_report_bloc.dart';

void initFinanceReportInjections() {
  getIt
    ..registerFactory<FinanceReportRemoteDataSource>(() {
      return FinanceReportRemoteDataSourceImpl(getIt());
    })
    // Repositories
    ..registerFactory<FinanceReportRepository>(() {
      return FinanceReportRepositoryImpl(
        getIt(),
        getIt(),
      );
    })
    // Use cases
    ..registerFactory(() => FinanceReportAddFixedIncome(getIt()))
    ..registerFactory(() => FinanceReportGetFixedIncome(getIt()))
    ..registerFactory(() => FinanceReportGetExpenseByMonth(getIt()))
    ..registerFactory(() => FinanceReportGetIncomeAndExpense(getIt()))
    // Bloc
    ..registerLazySingleton(() {
      return FinanceReportBloc(
        financeReportAddFixedIncome: getIt(),
        financeReportGetFixedIncome: getIt(),
        financeReportGetExpenseByMonth: getIt(),
        financeReportGetIncomeAndExpense: getIt(),
      );
    });
}
