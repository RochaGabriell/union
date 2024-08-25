/* Package Imports */
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:union/core/themes/palette.dart';

/* Project Imports */
import 'package:union/features/group/presentation/widgets/form/form_header.dart';
import 'package:union/features/group/presentation/widgets/form/group_form.dart';
import 'package:union/features/group/presentation/bloc/group_bloc.dart';
import 'package:union/features/group/domain/entities/group_entity.dart';
import 'package:union/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:union/core/common/cubit/user/user_cubit.dart';
import 'package:union/config/routes/router.dart' as routes;
import 'package:union/core/utils/show_dialog.dart';
import 'package:union/core/enums/alert_type.dart';
import 'package:union/core/utils/injections.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  void initState() {
    super.initState();
    _fetchGroups();
  }

  void _fetchGroups() {
    final String? userId = getIt.get<UserCubit>().user?.id;
    if (userId == null) return;
    getIt<GroupBloc>().add(GroupsGetEvent(userId: userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: const Text('Grupos'),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'Sair') {
                context.read<AuthBloc>().add(AuthLogoutEvent());
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  routes.login,
                  (route) => false,
                );
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'Sair', child: Text('Sair')),
            ],
          ),
        ],
      ),
      body: Center(
        child: BlocConsumer<GroupBloc, GroupState>(
          listener: _listener,
          builder: (context, state) {
            if (state is GroupLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GroupSuccessGetGroupsState) {
              return _buildGroupList(state.groups);
            }
            return const SizedBox();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showGroupForm(
          context,
          context.read<GroupBloc>().state,
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _listener(BuildContext context, GroupState state) {
    if (state is GroupErrorState) {
      _showErrorDialog(state.message);
    } else if (state is GroupSuccessState) {
      _showSuccessDialog();
    }
  }

  Widget _buildGroupList(List<GroupEntity> groups) {
    return ListView.builder(
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];
        return ListTile(
          splashColor: Palette.primary.withOpacity(0.1),
          leading: const CircleAvatar(child: Icon(Icons.group)),
          title: Text(group.name),
          subtitle: Text('Quantidade de membros: ${group.members.length}'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        );
      },
    );
  }

  void _showGroupForm(BuildContext context, GroupState state) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final creatorIdController = getIt.get<UserCubit>().user?.id;

    if (creatorIdController == null) return;

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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const FormHeader(),
                const Divider(),
                GroupForm(
                  formKey: formKey,
                  nameController: nameController,
                  state: state,
                  creatorIdController: creatorIdController,
                ),
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
      onRedirect: _fetchGroups,
    );
  }
}
