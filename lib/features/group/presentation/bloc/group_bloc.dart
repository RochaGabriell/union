/* Flutter Imports */
import 'package:flutter/material.dart';

/* Package Imports */
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union/features/group/domain/usecases/group_add_member.dart';

/* Project Imports */
import 'package:union/features/group/domain/usecases/group_get_groups.dart';
import 'package:union/features/group/domain/usecases/group_get_group.dart';
import 'package:union/features/group/domain/entities/group_entity.dart';
import 'package:union/features/group/domain/usecases/group_create.dart';
import 'package:union/features/group/domain/usecases/group_delete.dart';
import 'package:union/features/group/domain/usecases/group_update.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GroupCreate _groupCreate;
  final GroupUpdate _groupUpdate;
  final GroupDelete _groupDelete;
  final GroupGetGroup _groupGetGroup;
  final GroupGetGroups _groupGetGroups;

  GroupBloc({
    required GroupCreate groupCreate,
    required GroupUpdate groupUpdate,
    required GroupDelete groupDelete,
    required GroupGetGroup groupGetGroup,
    required GroupGetGroups groupGetGroups,
  })  : _groupCreate = groupCreate,
        _groupUpdate = groupUpdate,
        _groupDelete = groupDelete,
        _groupGetGroup = groupGetGroup,
        _groupGetGroups = groupGetGroups,
        super(GroupInitialState()) {
    on<GroupEvent>((event, emit) => emit(GroupLoadingState()));
    on<GroupCreateEvent>(_createGroup);
    on<GroupUpdateEvent>(_updateGroup);
    on<GroupDeleteEvent>(_deleteGroup);
    on<GroupGetEvent>(_getGroup);
    on<GroupsGetEvent>(_getGroups);
  }

  void _createGroup(GroupCreateEvent event, Emitter<GroupState> emit) async {
    final response = await _groupCreate(event.group);
    response.fold(
      (failure) => emit(GroupErrorState(failure.message)),
      (groupId) => emit(GroupSuccessState(groupId)),
    );
  }

  void _updateGroup(GroupUpdateEvent event, Emitter<GroupState> emit) async {
    final response = await _groupUpdate(event.group);
    response.fold(
      (failure) => emit(GroupErrorState(failure.message)),
      (_) => emit(GroupSuccessState(event.group.id)),
    );
  }

  void _deleteGroup(GroupDeleteEvent event, Emitter<GroupState> emit) async {
    final response = await _groupDelete(event.groupId);
    response.fold(
      (failure) => emit(GroupErrorState(failure.message)),
      (_) => emit(GroupSuccessState(event.groupId)),
    );
  }

  void _getGroup(GroupGetEvent event, Emitter<GroupState> emit) async {
    final response = await _groupGetGroup(event.groupId);
    response.fold(
      (failure) => emit(GroupErrorState(failure.message)),
      (group) => emit(GroupSuccessGetGroupState(group)),
    );
  }

  void _getGroups(GroupsGetEvent event, Emitter<GroupState> emit) async {
    final response = await _groupGetGroups(event.userId);
    response.fold(
      (failure) => emit(GroupErrorState(failure.message)),
      (groups) => emit(GroupSuccessGetGroupsState(groups)),
    );
  }
}
