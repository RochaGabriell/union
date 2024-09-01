/* Flutter Imports */
import 'package:flutter/material.dart';

/* Core Imports */
import 'package:union/core/enums/category_transaction.dart';
import 'package:union/core/themes/palette.dart';

/* Project Imports */
import 'package:union/features/transaction/domain/entities/transaction_entity.dart';

class TransactionList extends StatelessWidget {
  final List<TransactionEntity> transactions;
  final int filterSelected;
  final Function(String) onDelete;
  final EdgeInsets padding;

  const TransactionList({
    super.key,
    required this.transactions,
    this.filterSelected = -1,
    required this.onDelete,
    this.padding = const EdgeInsets.all(8),
  });

  List<TransactionEntity> _filterTransactions() {
    if (filterSelected == -1) return transactions;

    return transactions.where((transaction) {
      return transaction.category.name ==
          CategoryTransaction.values[filterSelected].name;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<TransactionEntity> filteredTransactions = _filterTransactions();
    final Brightness brightness = Theme.of(context).brightness;

    return ListView.builder(
      itemCount: filteredTransactions.length,
      itemBuilder: (context, index) {
        final transaction = filteredTransactions[index];
        return Padding(
          padding: padding,
          child: ExpansionTile(
            leading: CircleAvatar(
              backgroundColor: Palette.primary,
              child: _buildIcon(transaction.category.name),
            ),
            title: Text(transaction.description),
            subtitle: Text(
              '${_formatText(transaction.category.name)} - ${_formatText(transaction.type.name)}',
            ),
            trailing: Text(_formatValue(transaction.value)),
            children: [
              Container(
                decoration: BoxDecoration(
                  color: brightness == Brightness.light
                      ? Palette.white
                      : Palette.black,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text('Valor: ${_formatValue(transaction.value)}'),
                  subtitle: Text('Data: ${_formatDate(transaction.date)}'),
                  contentPadding: const EdgeInsets.only(left: 16, right: 8),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => onDelete(transaction.id ?? ''),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatText(String text) {
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  String _formatValue(double value) => 'R\$ ${value.toStringAsFixed(2)}';

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month < 10 ? '0' : ''}${date.month}/${date.year}';
  }

  Icon _buildIcon(String category) {
    switch (category) {
      case 'alimentacao':
        return const Icon(Icons.fastfood, color: Colors.white);
      case 'transporte':
        return const Icon(Icons.directions_bus, color: Colors.white);
      case 'saude':
        return const Icon(Icons.local_hospital, color: Colors.white);
      case 'educacao':
        return const Icon(Icons.school, color: Colors.white);
      case 'lazer':
        return const Icon(Icons.sports_esports, color: Colors.white);
      case 'moradia':
        return const Icon(Icons.home, color: Colors.white);
      case 'outros':
        return const Icon(Icons.more_horiz, color: Colors.white);
      default:
        return const Icon(Icons.more_horiz, color: Colors.white);
    }
  }
}
