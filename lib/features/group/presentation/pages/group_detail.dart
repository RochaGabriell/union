/* Flutter Imports */
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';

/* Core Imports */
import 'package:union/core/common/cubit/user/user_cubit.dart';
import 'package:union/core/utils/injections.dart';
import 'package:union/core/themes/palette.dart';

/* Project Imports */
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
  @override
  void initState() {
    super.initState();
    _fetchGroup();
  }

  Future<void> _fetchGroup() async {
    getIt<GroupBloc>().add(GroupGetEvent(groupId: widget.groupId));
  }

  Future<void> _fetchGroups() async {
    final String? userId = getIt.get<UserCubit>().user?.id;
    if (userId == null) return;
    getIt<GroupBloc>().add(GroupsGetEvent(userId: userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Detalhes do Grupo'),
      ),
      body: RefreshIndicator(
        onRefresh: _fetchGroup,
        color: Palette.primary,
        child: BlocBuilder<GroupBloc, GroupState>(
          builder: (context, state) {
            if (state is GroupLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GroupErrorState) {
              return Center(child: Text(state.message));
            }

            if (state is GroupSuccessGetGroupState) {
              return ListView(
                children: [
                  QrImageView(
                    data: '${state.group.id}|${state.group.creatorId}',
                    version: QrVersions.auto,
                    size: 250.0,
                    eyeStyle: const QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: Palette.black,
                    ),
                    dataModuleStyle: const QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.square,
                      color: Palette.black,
                    ),
                  ),
                  ListTile(
                    title: Text(state.group.name),
                    subtitle: Text(state.group.description),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fetchGroups();
    super.dispose();
  }
}
