part of 'group_bloc.dart';

@immutable
sealed class GroupState {
  const GroupState();
}

final class GroupInitialState extends GroupState {}

final class GroupLoadingState extends GroupState {}

final class GroupErrorState extends GroupState {
  final String message;

  const GroupErrorState(this.message);
}

final class GroupSuccessState extends GroupState {
  final String? groupId;

  const GroupSuccessState(this.groupId);
}

final class GroupSuccessGetGroupState extends GroupState {
  final GroupEntity group;
  final List<Map<String, String>> membersNames;

  const GroupSuccessGetGroupState(this.group, this.membersNames);
}

final class GroupSuccessGetGroupsState extends GroupState {
  final List<GroupEntity> groups;

  const GroupSuccessGetGroupsState(this.groups);
}

final class GroupSuccessDeleteState extends GroupState {}

final class GroupSuccessAddMemberState extends GroupState {}

final class GroupSuccessRemoveMemberState extends GroupState {}
