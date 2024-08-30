/* Flutter Imports */
import 'package:flutter/material.dart';

/* Project Imports */
import 'package:union/features/finance_report/presentation/pages/finance_report.dart';
import 'package:union/features/transaction/presentation/pages/transaction.dart';
import 'package:union/features/group/presentation/pages/group.dart';
import 'package:union/core/themes/palette.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _BaseState();
}

class _BaseState extends State<NavigationPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    const Radius radius = Radius.circular(10);

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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: brightness == Brightness.light
                  ? Palette.black.withOpacity(0.1)
                  : Palette.white.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: radius,
            topRight: radius,
          ),
          child: NavigationBar(
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
        ),
      ),
    );
  }
}
