/* Project imports */
import 'package:union/features/finance_report/presentation/widgets/utils/individual_bar.dart';

class MonthlyData {
  final double january;
  final double february;
  final double march;
  final double april;
  final double may;
  final double june;
  final double july;
  final double august;
  final double september;
  final double october;
  final double november;
  final double december;

  MonthlyData({
    required this.january,
    required this.february,
    required this.march,
    required this.april,
    required this.may,
    required this.june,
    required this.july,
    required this.august,
    required this.september,
    required this.october,
    required this.november,
    required this.december,
  });

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      IndividualBar(x: 1, y: january),
      IndividualBar(x: 2, y: february),
      IndividualBar(x: 3, y: march),
      IndividualBar(x: 4, y: april),
      IndividualBar(x: 5, y: may),
      IndividualBar(x: 6, y: june),
      IndividualBar(x: 7, y: july),
      IndividualBar(x: 8, y: august),
      IndividualBar(x: 9, y: september),
      IndividualBar(x: 10, y: october),
      IndividualBar(x: 11, y: november),
      IndividualBar(x: 12, y: december),
    ];
  }
}
