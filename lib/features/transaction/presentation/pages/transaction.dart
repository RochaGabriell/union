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
import 'package:union/features/transaction/presentation/widgets/transaction_app_bar.dart';
import 'package:union/features/transaction/presentation/widgets/transaction_list.dart';
import 'package:union/features/transaction/presentation/bloc/transaction_bloc.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  int filterSelected = -1;

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

  void _changeFilter(int index) {
    setState(() => filterSelected = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransactionAppBar(
        filterSelected: filterSelected,
        onFilterChange: _changeFilter,
      ),
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

              return TransactionList(
                transactions: state.transactions,
                filterSelected: filterSelected,
                onDelete: (id) {
                  context.read<TransactionBloc>().add(
                        TransactionDeleteEvent(transactionId: id),
                      );
                },
              );
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
      _showSuccessDialog('Despesa cadastrada com sucesso!');
    } else if (state is TransactionSuccessDeleteState) {
      _showSuccessDialog('Despesa excluída com sucesso!');
    }
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

  void _showSuccessDialog(String message) {
    showMessageDialog(
      context,
      title: 'Sucesso!',
      message: message,
      type: AlertType.success,
      onRedirect: _fetchTransactions,
    );
  }
}
