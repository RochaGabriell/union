/* Flutter Imports */
import 'package:flutter/material.dart';
import 'package:union/features/finance_report/presentation/pages/finance_report.dart';
import 'package:union/features/group/presentation/pages/group.dart';
import 'package:union/features/transaction/presentation/pages/transaction.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _BaseState();
}

class _BaseState extends State<NavigationPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    const List<Widget> pages = [
      GroupPage(),
      TransactionPage(),
      FinanceReportPage(),
    ];
    final List<IconData> icons = [
      Icons.group,
      Icons.attach_money,
      Icons.bar_chart,
    ];
    const List<String> labels = [
      'Grupos',
      'Despesas',
      'Relatórios',
    ];

    return Scaffold(
      body: IndexedStack(index: currentPageIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        destinations: List.generate(icons.length, (index) {
          return NavigationDestination(
            icon: Icon(icons[index]),
            label: labels[index],
          );
        }),
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) => setState(() {
          currentPageIndex = index;
        }),
        animationDuration: const Duration(milliseconds: 500),
      ),
    );
  }
}
