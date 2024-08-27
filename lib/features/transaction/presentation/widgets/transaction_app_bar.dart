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
      label: _buildIcon(label),
      selected: filterSelected == value,
      onSelected: (selected) => onFilterChange(value),
    );
  }

  Icon _buildIcon(String filter) {
    switch (filter) {
      case 'todos':
        return const Icon(Icons.all_inbox, color: Palette.primary);
      case 'alimentacao':
        return const Icon(Icons.fastfood, color: Palette.primary);
      case 'transporte':
        return const Icon(Icons.directions_bus, color: Palette.primary);
      case 'saude':
        return const Icon(Icons.local_hospital, color: Palette.primary);
      case 'educacao':
        return const Icon(Icons.school, color: Palette.primary);
      case 'lazer':
        return const Icon(Icons.sports_esports, color: Palette.primary);
      case 'moradia':
        return const Icon(Icons.home, color: Palette.primary);
      case 'outros':
        return const Icon(Icons.more_horiz, color: Palette.primary);
      default:
        return const Icon(Icons.more_horiz, color: Palette.primary);
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(96);
}
