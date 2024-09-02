/* Package Imports */
import 'package:fpdart/fpdart.dart';

/* Project Imports */
import 'package:union/features/finance_report/domain/repositories/finance_report_repository.dart';
import 'package:union/core/usecase/usecase.dart';
import 'package:union/core/errors/failures.dart';

class FinanceReportAddFixedIncome
    implements UseCase<double, FinanceReportAddFixedIncomeParams> {
  final FinanceReportRepository _financeReportRepository;

  FinanceReportAddFixedIncome(this._financeReportRepository);

  @override
  Future<Either<Failure, double>> call(
      FinanceReportAddFixedIncomeParams params) async {
    return await _financeReportRepository.addFixedIncome(
      userId: params.userId,
      value: params.value,
    );
  }
}

class FinanceReportAddFixedIncomeParams {
  final String userId;
  final double value;

  FinanceReportAddFixedIncomeParams({
    required this.userId,
    required this.value,
  });
}
