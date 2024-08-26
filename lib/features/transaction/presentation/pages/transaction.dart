/* Flutter Imports */
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

/* Core Imports */
import 'package:union/core/common/cubit/user/user_cubit.dart';
import 'package:union/core/common/widgets/form_header.dart';
import 'package:union/core/utils/show_dialog.dart';
import 'package:union/core/enums/alert_type.dart';
import 'package:union/core/utils/injections.dart';
import 'package:union/core/themes/palette.dart';

/* Project Imports */
import 'package:union/features/transaction/presentation/widgets/form/transaction_form.dart';
import 'package:union/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:union/features/transaction/domain/entities/transaction_entity.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  Future<void> _fetchTransactions() async {
    final String? userId = getIt.get<UserCubit>().user?.id;
    if (userId == null) return;
    getIt<TransactionBloc>().add(TransactionsGetEvent(userId: userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Despesas')),
      body: RefreshIndicator(
        onRefresh: _fetchTransactions,
        color: Palette.primary,
        child: BlocConsumer<TransactionBloc, TransactionState>(
          listener: _listener,
          builder: (context, state) {
            if (state is TransactionLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TransactionSuccessGetTransactionsState) {
              if (state.transactions.isEmpty) {
                return const Center(
                  child: Text('Nenhuma despesa encontrada.'),
                );
              }
              return _buildTransactionList(state.transactions);
            }
            return const SizedBox();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'addTransaction',
        onPressed: () => _showGroupForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _listener(BuildContext context, TransactionState state) {
    if (state is TransactionErrorState) {
      _showErrorDialog(state.message);
    } else if (state is TransactionSuccessState) {
      _showSuccessDialog();
    }
  }

  Widget _buildTransactionList(List<TransactionEntity> groups) {
    return ListView.builder(
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];
        return ExpansionTile(
          leading: CircleAvatar(
            backgroundColor: Palette.primary,
            child: _buildIcon(group.category.name),
          ),
          title: Text(group.description),
          subtitle: Text(
            '${_formatText(group.category.name)} - ${_formatText(group.type.name)}',
          ),
          trailing: Text(_formatValue(group.value)),
          children: [
            ListTile(
              title: Text('Valor: ${_formatValue(group.value)}'),
              subtitle: Text('Data: ${_formatDate(group.date)}'),
              contentPadding: const EdgeInsets.only(left: 16, right: 8),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
          // onTap: () {},
        );
      },
    );
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

  String _formatText(String text) {
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  String _formatValue(double value) => 'R\$ ${value.toStringAsFixed(2)}';

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month < 10 ? '0' : ''}${date.month}/${date.year}';
  }

  void _showGroupForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            height: MediaQuery.of(context).size.height * 0.8,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FormHeader(title: 'Nova Despesa'),
                Divider(),
                Expanded(child: TransactionForm()),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showMessageDialog(
      context,
      title: 'Erro!',
      message: message,
      type: AlertType.error,
      onConfirm: () {},
    );
  }

  void _showSuccessDialog() {
    showMessageDialog(
      context,
      title: 'Sucesso!',
      message: 'Grupo criado com sucesso.',
      type: AlertType.success,
      onRedirect: _fetchTransactions,
    );
  }
}
