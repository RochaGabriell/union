/* Project imports */
import 'package:union/features/finance_report/presentation/widgets/utils/individual_bar.dart';

class IncomeData {
  final double fixedIncome;
  final double expense;

  IncomeData({
    required this.fixedIncome,
    required this.expense,
  });

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      IndividualBar(x: 1, y: fixedIncome),
      IndividualBar(x: 2, y: expense),
    ];
  }
}
