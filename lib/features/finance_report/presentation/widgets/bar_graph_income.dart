/* Package Imports */
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

/* Project Imports */
import 'package:union/features/finance_report/presentation/widgets/utils/income_data.dart';
import 'package:union/core/themes/palette.dart';

class BarGraphIncome extends StatelessWidget {
  final String title;
  final List<double> data;
  final List<String> labels;

  const BarGraphIncome({
    super.key,
    required this.title,
    required this.data,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    final String title = this.title;
    final List<double> data = this.data;

    final IncomeData barData = IncomeData(
      fixedIncome: data[0],
      expense: data[1],
    );

    final maxValue = data.reduce(max);

    barData.initializeBarData();

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
          height: 350,
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.only(
            top: 30,
            bottom: 10,
            left: 10,
            right: 10,
          ),
          decoration: BoxDecoration(
            color: Palette.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(color: Colors.grey, blurRadius: 1.0),
            ],
          ),
          child: BarChart(
            BarChartData(
              maxY: maxValue.toDouble(),
              minY: 0,
              borderData: FlBorderData(
                border: const Border(bottom: BorderSide(), left: BorderSide()),
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(sideTitles: _bottomTitles),
              ),
              barGroups: [
                barGroup(1, data[0], Palette.success),
                barGroup(2, data[1], Palette.error),
              ],
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      '${labels[groupIndex]}'
                      '\n'
                      'Total: ${rod.toY}',
                      const TextStyle(color: Colors.white),
                    );
                  },
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  BarChartGroupData barGroup(int index, double data, Color color) {
    return BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
          toY: data,
          color: color,
          width: 40,
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
            text = 'Renda';
            break;
          case 2:
            text = 'Despesa';
            break;
        }
        return Text(text);
      },
    );
  }
}
