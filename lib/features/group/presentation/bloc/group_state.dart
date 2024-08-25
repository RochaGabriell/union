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

  const GroupSuccessGetGroupState(this.group);
}

final class GroupSuccessGetGroupsState extends GroupState {
  final List<GroupEntity> groups;

  const GroupSuccessGetGroupsState(this.groups);
}
