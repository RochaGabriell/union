/* Package Imports */
import 'package:flutter/material.dart';

/* Project Imports */
import 'package:union/core/common/cubit/user/user_cubit.dart';
import 'package:union/core/utils/injections.dart';
import 'package:union/core/themes/palette.dart';
import 'package:union/features/finance_report/domain/usecases/finance_report_add_fixed_income.dart';
import 'package:union/features/finance_report/presentation/bloc/finance_report_bloc.dart';
import 'package:union/features/finance_report/presentation/widgets/bar_graph_income.dart';
import 'package:union/features/finance_report/presentation/widgets/line_graph.dart';
import 'package:union/features/transaction/presentation/widgets/currency_input_field.dart';

class FinanceReportPage extends StatefulWidget {
  const FinanceReportPage({super.key});

  @override
  State<FinanceReportPage> createState() => _FinanceReportPageState();
}

class _FinanceReportPageState extends State<FinanceReportPage> {
  final String titleAgeGroup = 'Receita por mês';
  List<double> monthlyData = List.generate(12, (_) => 0.0);
  final List<String> labelsAgeGroup = [
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

  final String titleGender = 'Despesas';
  List<double> incomeData = [0.0, 0.0];
  final List<String> labelsGender = ['Receita', 'Despesa'];

  double fixedIncome = 0.0;

  final TextEditingController _fixedIncomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final String? userId = getIt<UserCubit>().user?.id;
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

    financeReportBloc.add(FinanceReportGetExpenseByMonthEvent(userId: userId));
    financeReportBloc.stream.listen((state) {
      if (state is FinanceReportSuccessGetExpenseByMonth) {
        setState(() {
          monthlyData = state.expenseByMonth;
        });
      }
    });

    financeReportBloc.add(FinanceReportGetFixedIncomeEvent(userId: userId));
    financeReportBloc.stream.listen((state) {
      if (state is FinanceReportFixedIncome) {
        setState(() {
          fixedIncome = state.value;
        });
      }
    });
  }

  void _editFixedIncome() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Receita Fixa'),
          content: CurrencyInputField(
            valueController: _fixedIncomeController,
            disposed: false,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                String value = _fixedIncomeController.text
                    .replaceAll(RegExp(r'[^0-9,]'), '');
                value = value.replaceAll(',', '.');

                final userId = getIt<UserCubit>().user?.id;
                if (userId == null) return;

                final financeReportBloc = getIt<FinanceReportBloc>();
                financeReportBloc.add(FinanceReportAddFixedIncomeEvent(
                  params: FinanceReportAddFixedIncomeParams(
                    userId: userId,
                    value: double.parse(value),
                  ),
                ));

                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
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
            _buildFixedIncomeCard(),
            const SizedBox(height: 16.0),
            LineGraph(
                title: titleAgeGroup,
                data: monthlyData,
                labels: labelsAgeGroup),
            BarGraphIncome(
                title: titleGender, data: incomeData, labels: labelsGender),
          ],
        ),
      ),
    );
  }

  Widget _buildFixedIncomeCard() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Palette.primary,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          const Text(
            'Receita Fixa',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Palette.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'R\$ $fixedIncome',
                style: const TextStyle(
                  fontSize: 24.0,
                  color: Palette.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Palette.white),
                onPressed: _editFixedIncome,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
