/* Flutter Imports */
import 'package:flutter/material.dart';

/* Package Imports */
import 'package:flutter_bloc/flutter_bloc.dart';

/* Project Imports */
import 'package:union/features/group/domain/usecases/group_get_members_names.dart';
import 'package:union/features/group/domain/usecases/group_remove_member.dart';
import 'package:union/features/group/domain/usecases/group_add_member.dart';
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
  final GroupAddMember _groupAddMember;
  final GroupRemoveMember _groupRemoveMember;
  final GroupGetMembersNames _groupGetMembersNames;

  GroupBloc({
    required GroupCreate groupCreate,
    required GroupUpdate groupUpdate,
    required GroupDelete groupDelete,
    required GroupGetGroup groupGetGroup,
    required GroupGetGroups groupGetGroups,
    required GroupAddMember groupAddMember,
    required GroupRemoveMember groupRemoveMember,
    required GroupGetMembersNames groupGetMembersNames,
  })  : _groupCreate = groupCreate,
        _groupUpdate = groupUpdate,
        _groupDelete = groupDelete,
        _groupGetGroup = groupGetGroup,
        _groupGetGroups = groupGetGroups,
        _groupAddMember = groupAddMember,
        _groupRemoveMember = groupRemoveMember,
        _groupGetMembersNames = groupGetMembersNames,
        super(GroupInitialState()) {
    on<GroupEvent>((event, emit) => emit(GroupLoadingState()));
    on<GroupCreateEvent>(_createGroup);
    on<GroupUpdateEvent>(_updateGroup);
    on<GroupDeleteEvent>(_deleteGroup);
    on<GroupGetEvent>(_getGroup);
    on<GroupsGetEvent>(_getGroups);
    on<GroupAddMemberEvent>(_addMember);
    on<GroupRemoveMemberEvent>(_removeMember);
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
      (_) => emit(GroupSuccessDeleteState()),
    );
  }

  void _getGroup(GroupGetEvent event, Emitter<GroupState> emit) async {
    final responseGroup = await _groupGetGroup(event.groupId);
    final responseMembers = await _groupGetMembersNames(event.groupId);
    responseGroup.fold(
      (failure) => emit(GroupErrorState(failure.message)),
      (group) => responseMembers.fold(
        (failure) => emit(GroupErrorState(failure.message)),
        (membersNames) => emit(GroupSuccessGetGroupState(group, membersNames)),
      ),
    );
  }

  void _getGroups(GroupsGetEvent event, Emitter<GroupState> emit) async {
    final response = await _groupGetGroups(event.userId);
    response.fold(
      (failure) => emit(GroupErrorState(failure.message)),
      (groups) {
        emit(GroupSuccessGetGroupsState(groups));
      },
    );
  }

  void _addMember(GroupAddMemberEvent event, Emitter<GroupState> emit) async {
    final response = await _groupAddMember(event.params);
    response.fold(
      (failure) => emit(GroupErrorState(failure.message)),
      (_) => emit(GroupSuccessAddMemberState()),
    );
  }

  void _removeMember(
      GroupRemoveMemberEvent event, Emitter<GroupState> emit) async {
    final response = await _groupRemoveMember(event.params);
    response.fold(
      (failure) => emit(GroupErrorState(failure.message)),
      (_) => emit(GroupSuccessRemoveMemberState()),
    );
  }
}
