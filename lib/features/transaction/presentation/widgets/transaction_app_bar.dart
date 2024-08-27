/* Flutter Imports */
import 'package:flutter/material.dart';

/* Core Imports */
import 'package:union/core/enums/category_transaction.dart';
import 'package:union/core/themes/palette.dart';

class TransactionAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int filterSelected;
  final Function(int) onFilterChange;

  const TransactionAppBar({
    super.key,
    required this.filterSelected,
    required this.onFilterChange,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text('Despesas'),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              _buildChoiceChip('todos', -1),
              const SizedBox(width: 8),
              ...CategoryTransaction.values.map(
                (category) {
                  return Row(
                    children: [
                      _buildChoiceChip(
                        category.name,
                        CategoryTransaction.values.indexOf(category),
                      ),
                      const SizedBox(width: 8),
                    ],
                  );
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }

  ChoiceChip _buildChoiceChip(String label, int value) {
    return ChoiceChip(
      label: _buildIcon(label, value),
      selected: filterSelected == value,
      onSelected: (selected) => onFilterChange(value),
    );
  }

  Icon _buildIcon(String filter, int value) {
    final color = filterSelected == value ? Palette.secondary : Palette.primary;

    switch (filter) {
      case 'todos':
        return Icon(Icons.all_inbox, color: color);
      case 'alimentacao':
        return Icon(Icons.fastfood, color: color);
      case 'transporte':
        return Icon(Icons.directions_bus, color: color);
      case 'saude':
        return Icon(Icons.local_hospital, color: color);
      case 'educacao':
        return Icon(Icons.school, color: color);
      case 'lazer':
        return Icon(Icons.sports_esports, color: color);
      case 'moradia':
        return Icon(Icons.home, color: color);
      case 'outros':
        return Icon(Icons.more_horiz, color: color);
      default:
        return Icon(Icons.more_horiz, color: color);
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(96);
}
