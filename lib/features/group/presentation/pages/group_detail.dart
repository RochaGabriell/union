/* Flutter Imports */
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';

/* Core Imports */
import 'package:union/core/common/cubit/user/user_cubit.dart';
import 'package:union/core/utils/show_dialog.dart';
import 'package:union/core/enums/alert_type.dart';
import 'package:union/core/utils/injections.dart';
import 'package:union/core/themes/palette.dart';
import 'package:union/features/group/domain/usecases/group_remove_member.dart';

/* Project Imports */
import 'package:union/features/transaction/presentation/widgets/transaction_list.dart';
import 'package:union/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:union/features/group/presentation/bloc/group_bloc.dart';

class GroupDetailPage extends StatefulWidget {
  final String groupId;

  const GroupDetailPage({
    super.key,
    required this.groupId,
  });

  @override
  State<GroupDetailPage> createState() => _GroupDetailPageState();
}

class _GroupDetailPageState extends State<GroupDetailPage> {
  final String? _userId = getIt.get<UserCubit>().user?.id;
  String? _isCreator;

  @override
  void initState() {
    super.initState();
    _fetchGroup();
    _fetchTransactions();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> _fetchGroup() async {
    getIt<GroupBloc>().add(GroupGetEvent(groupId: widget.groupId));

    getIt<GroupBloc>().stream.listen((state) {
      if (state is GroupSuccessGetGroupState) {
        setState(() {
          _isCreator = state.group.creatorId;
        });
      }
    });
  }

  Future<void> _fetchGroups() async {
    final String? userId = _userId;
    if (userId == null) return;

    getIt<GroupBloc>().add(GroupsGetEvent(userId: userId));
  }

  Future<void> _fetchTransactions() async {
    final String? userId = getIt.get<UserCubit>().user?.id;
    if (userId == null) return;
    getIt<TransactionBloc>().add(TransactionsGetByGroupEvent(
      groupId: widget.groupId,
    ));
  }

  Future<void> _deleteGroup(
    BuildContext context,
    GroupSuccessGetGroupState state,
  ) async {
    showMessageDialog(
      context,
      barrierDismissible: true,
      title: 'Deletar Grupo',
      message: 'Deseja realmente deletar o grupo?',
      type: AlertType.warning,
      onDismiss: () => {},
      onConfirm: () {
        getIt<GroupBloc>().add(GroupDeleteEvent(groupId: state.group.id ?? ''));
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupBloc, GroupState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: state is GroupSuccessGetGroupState
                ? Text(
                    state.group.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : const Text('Grupo'),
            actions: state is GroupSuccessGetGroupState
                ? _actions(context, state)
                : [],
          ),
          body: RefreshIndicator(
            onRefresh: _fetchGroup,
            color: Palette.primary,
            child: _buildBody(state),
          ),
        );
      },
    );
  }

  List<Widget> _actions(BuildContext context, GroupSuccessGetGroupState state) {
    return [
      IconButton(
        icon: const Icon(Icons.qr_code_2),
        onPressed: () => _showQrDialog(context, state),
      ),
      Visibility(
        visible: _isCreator == _userId,
        child: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => _deleteGroup(context, state),
        ),
      ),
    ];
  }

  Widget _buildBody(GroupState state) {
    if (state is GroupLoadingState) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is GroupErrorState) {
      return Center(child: Text(state.message));
    } else if (state is GroupSuccessGetGroupState) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildMembers(state),
            const Divider(height: 32.0, thickness: 2.0),
            Expanded(
              child: BlocBuilder<TransactionBloc, TransactionState>(
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
                      padding: const EdgeInsets.all(0),
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
            )
          ],
        ),
      );
    }

    return const SizedBox();
  }

  Widget _buildMembers(GroupSuccessGetGroupState state) {
    final idCreator = state.group.creatorId;

    return Column(
      children: [
        const Text(
          'Membros',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        if (state.membersNames.isEmpty)
          const Center(child: Text('Nenhum membro encontrado.'))
        else
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(state.membersNames.length, (index) {
              final member = state.membersNames[index];
              final isCreator = _userId == idCreator;
              final isUser = _userId == member['id'];

              return index == 0
                  ? Chip(
                      label: Text(member['name'] ?? ''),
                      backgroundColor: Palette.primary,
                      labelStyle: const TextStyle(color: Palette.secondary),
                    )
                  : !isCreator && !isUser
                      ? Chip(label: Text(member['name'] ?? ''))
                      : GestureDetector(
                          child: Chip(label: Text(member['name'] ?? '')),
                          onTap: () {
                            showMessageDialog(
                              context,
                              title:
                                  isUser ? 'Sair do Grupo' : 'Remover Membro',
                              message: isUser
                                  ? 'Deseja sair do grupo?'
                                  : 'Deseja realmente remover o membro?',
                              type: AlertType.warning,
                              onDismiss: () => {},
                              onConfirm: () {
                                getIt<GroupBloc>().add(GroupRemoveMemberEvent(
                                  params: GroupRemoveMemberParams(
                                    groupId: state.group.id ?? '',
                                    userId: member['id'] ?? '',
                                  ),
                                ));
                                isUser
                                    ? Navigator.of(context).pop()
                                    : _fetchGroup();
                              },
                            );
                          },
                        );
            }).toList(),
          )
      ],
    );
  }

  void _showQrDialog(BuildContext context, GroupSuccessGetGroupState state) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('QR Code do Grupo', textAlign: TextAlign.center),
          content: SizedBox(
            width: 250.0,
            height: 250.0,
            child: _buildQrImage(state),
          ),
        );
      },
    );
  }

  QrImageView _buildQrImage(GroupSuccessGetGroupState state) {
    const color = Palette.black;

    return QrImageView(
      size: 250.0,
      version: QrVersions.auto,
      data: '${state.group.id}|${state.group.creatorId}',
      eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: color),
      dataModuleStyle: const QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.square,
        color: color,
      ),
    );
  }

  @override
  void dispose() {
    _fetchGroups();
    super.dispose();
  }
}
