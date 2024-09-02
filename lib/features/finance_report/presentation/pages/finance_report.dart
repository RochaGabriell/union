/* Package Imports */
import 'package:flutter/material.dart';

/* Project Imports */
import 'package:union/features/finance_report/presentation/widgets/line_graph.dart';
import 'package:union/features/finance_report/presentation/bloc/finance_report_bloc.dart';
import 'package:union/features/finance_report/presentation/widgets/bar_graph_income.dart';
import 'package:union/core/common/cubit/user/user_cubit.dart';
import 'package:union/core/utils/injections.dart';

class FinanceReportPage extends StatefulWidget {
  const FinanceReportPage({super.key});

  @override
  State<FinanceReportPage> createState() => _FinanceReportPageState();
}

class _FinanceReportPageState extends State<FinanceReportPage> {
  String titleAgeGroup = 'Receita por mês';
  List<double> monthlyData = [
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
  ];
  List<String> labelsAgeGroup = [
    'Jan',
    'Fev',
    'Mar',
    'Abr',
    'Mai',
    'Jun',
    'Jul',
    'Ago',
    'Set',
    'Out',
    'Nov',
    'Dez',
  ];

  String titleGender = 'Despesas';
  List<double> incomeData = [0.0, 0.0];
  List<String> labelsGender = ['Receita', 'Despesa'];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final String? userId = getIt.get<UserCubit>().user?.id;
    if (userId == null) return;

    final financeReportBloc = getIt<FinanceReportBloc>();

    financeReportBloc.add(
      FinanceReportGetIncomeAndExpenseEvent(userId: userId),
    );

    financeReportBloc.stream.listen((state) {
      if (state is FinanceReportSuccessGetIncomeAndExpense) {
        setState(() {
          incomeData = state.incomeAndExpense;
        });
      }
    });

    getIt<FinanceReportBloc>().add(
      FinanceReportGetExpenseByMonthEvent(userId: userId),
    );

    financeReportBloc.stream.listen((state) {
      if (state is FinanceReportSuccessGetExpenseByMonth) {
        setState(() {
          monthlyData = state.expenseByMonth;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Relatório Financeiro'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _fetchData),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            LineGraph(
              title: titleAgeGroup,
              data: monthlyData,
              labels: labelsAgeGroup,
            ),
            BarGraphIncome(
              title: titleGender,
              data: incomeData,
              labels: labelsGender,
            ),
          ],
        ),
      ),
    );
  }
}
