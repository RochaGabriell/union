/* Package Imports */
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

/* Project Imports */
import 'package:union/features/finance_report/presentation/widgets/utils/monthly_data.dart';
import 'package:union/core/themes/palette.dart';

class LineGraph extends StatelessWidget {
  final String title;
  final List<double> data;
  final List<String> labels;

  const LineGraph({
    super.key,
    required this.title,
    required this.data,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    final String title = this.title;
    final List<double> data = this.data;

    final MonthlyData barData = MonthlyData(
      january: data[0],
      february: data[1],
      march: data[2],
      april: data[3],
      may: data[4],
      june: data[5],
      july: data[6],
      august: data[7],
      september: data[8],
      october: data[9],
      november: data[10],
      december: data[11],
    );

    final maxValue = data.reduce(max);

    barData.initializeBarData();

    const axisTitles = AxisTitles(sideTitles: SideTitles(showTitles: false));

    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 300,
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.only(right: 30, top: 30, bottom: 20),
          decoration: BoxDecoration(
            color: Palette.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(color: Colors.grey, blurRadius: 1.0),
            ],
          ),
          child: LineChart(
            LineChartData(
              maxY: maxValue.toDouble(),
              minY: 0,
              borderData: FlBorderData(
                border: const Border(bottom: BorderSide(), left: BorderSide()),
              ),
              titlesData: FlTitlesData(
                show: true,
                topTitles: axisTitles,
                rightTitles: axisTitles,
                bottomTitles: AxisTitles(sideTitles: _bottomTitles),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: barData.barData.map((data) {
                    return FlSpot(data.x.toDouble(), data.y.toDouble());
                  }).toList(),
                  isCurved: false,
                ),
              ],
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (List<LineBarSpot> touchedSpots) {
                    return touchedSpots.map((LineBarSpot touchedSpot) {
                      return LineTooltipItem(
                        '${labels[touchedSpot.x.toInt() - 1]}'
                        '\n'
                        'Total: ${touchedSpot.y.toInt()}',
                        const TextStyle(color: Colors.white),
                      );
                    }).toList();
                  },
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  SideTitles get _bottomTitles {
    return SideTitles(
      showTitles: true,
      getTitlesWidget: (value, meta) {
        String text = '';
        switch (value.toInt()) {
          case 1:
            text = 'J';
            break;
          case 2:
            text = 'F';
            break;
          case 3:
            text = 'M';
            break;
          case 4:
            text = 'A';
            break;
          case 5:
            text = 'M';
            break;
          case 6:
            text = 'J';
            break;
          case 7:
            text = 'J';
            break;
          case 8:
            text = 'A';
            break;
          case 9:
            text = 'S';
            break;
          case 10:
            text = 'O';
            break;
          case 11:
            text = 'N';
            break;
          case 12:
            text = 'D';
            break;
        }
        return Text(text);
      },
    );
  }
}
