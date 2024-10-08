/* Package Imports */
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union/core/themes/palette.dart';
import 'package:flutter/material.dart';

/* Core Imports */
import 'package:union/core/common/cubit/user/user_cubit.dart';
import 'package:union/core/common/widgets/form_header.dart';
import 'package:union/config/routes/router.dart' as routes;
import 'package:union/core/utils/show_dialog.dart';
import 'package:union/core/enums/alert_type.dart';
import 'package:union/core/utils/injections.dart';

/* Project Imports */
import 'package:union/features/group/presentation/widgets/form/group_form.dart';
import 'package:union/features/group/presentation/widgets/group_app_bar.dart';
import 'package:union/features/group/presentation/bloc/group_bloc.dart';
import 'package:union/features/group/domain/entities/group_entity.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  int filterSelected = 0;

  @override
  void initState() {
    super.initState();
    _fetchGroups();
  }

  Future<void> _fetchGroups() async {
    final String? userId = getIt.get<UserCubit>().user?.id;
    if (userId == null) return;

    getIt<GroupBloc>().add(GroupsGetEvent(userId: userId));
  }

  void _changeFilter(int index) {
    setState(() => filterSelected = index);
  }

  List<GroupEntity> _filterGroups(List<GroupEntity> groups) {
    final String? userId = getIt.get<UserCubit>().user?.id;
    if (userId == null) return [];

    switch (filterSelected) {
      case 0:
        return groups;
      case 1:
        return groups.where((group) {
          return group.creatorId == userId;
        }).toList();
      case 2:
        return groups.where((group) {
          return group.members.contains(userId);
        }).toList();
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GroupAppBar(
        filterSelected: filterSelected,
        onFilterChange: _changeFilter,
      ),
      body: RefreshIndicator(
        onRefresh: _fetchGroups,
        color: Palette.primary,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: BlocConsumer<GroupBloc, GroupState>(
          listener: _listener,
          builder: (context, state) {
            if (state is GroupLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GroupSuccessGetGroupsState) {
              if (state.groups.isEmpty) {
                return const Center(
                  child: Text('Nenhum grupo encontrado. 😢'),
                );
              }
              return _buildGroupList(state.groups);
            }
            return const SizedBox();
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'scanQR',
            onPressed: () {
              Navigator.pushNamed(context, routes.qrViewer);
            },
            child: const Icon(Icons.qr_code),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'addGroup',
            onPressed: () => _showGroupForm(context),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  void _listener(BuildContext context, GroupState state) {
    if (state is GroupErrorState) {
      _showErrorDialog(state.message);
    } else if (state is GroupSuccessState) {
      _showSuccessDialog('Grupo criado com sucesso.');
    } else if (state is GroupSuccessDeleteState) {
      _showSuccessDialog('Grupo deletado com sucesso.');
    } else if (state is GroupSuccessAddMemberState) {
      _showSuccessDialog('Membro adicionado com sucesso.');
    }
  }

  Widget _buildGroupList(List<GroupEntity> groups) {
    final List<GroupEntity> filteredGroups = _filterGroups(groups);
    final Brightness brightness = Theme.of(context).brightness;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: filteredGroups.length,
        itemBuilder: (context, index) {
          final group = filteredGroups[index];
          return Container(
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
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              splashColor: Palette.secondary,
              leading: const CircleAvatar(
                backgroundColor: Palette.primary,
                child: Icon(Icons.group, color: Colors.white),
              ),
              title: Text(group.name),
              subtitle: Text(
                group.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  routes.groupDetail,
                  arguments: group.id,
                );
              },
            ),
          );
        },
      ),
    );
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
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FormHeader(title: 'Criar Grupo'),
                Divider(),
                GroupForm(),
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

    _fetchGroups();
  }

  void _showSuccessDialog(String message) {
    showMessageDialog(
      context,
      title: 'Sucesso!',
      message: message,
      type: AlertType.success,
      onRedirect: _fetchGroups,
    );
  }
}
