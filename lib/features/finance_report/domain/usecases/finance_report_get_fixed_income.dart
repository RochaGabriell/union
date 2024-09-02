/* Package Imports */
import 'package:fpdart/fpdart.dart';

/* Project Imports */
import 'package:union/features/finance_report/domain/repositories/finance_report_repository.dart';
import 'package:union/core/usecase/usecase.dart';
import 'package:union/core/errors/failures.dart';

class FinanceReportGetFixedIncome implements UseCase<double, String> {
  final FinanceReportRepository _financeReportRepository;

  FinanceReportGetFixedIncome(this._financeReportRepository);

  @override
  Future<Either<Failure, double>> call(String userId) async {
    return await _financeReportRepository.getFixedIncomeUser(userId: userId);
  }
}
