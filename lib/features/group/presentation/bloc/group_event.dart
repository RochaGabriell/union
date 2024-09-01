part of 'group_bloc.dart';

@immutable
sealed class GroupEvent {}

final class GroupCreateEvent extends GroupEvent {
  final GroupEntity group;

  GroupCreateEvent({required this.group});
}

final class GroupUpdateEvent extends GroupEvent {
  final GroupEntity group;

  GroupUpdateEvent({required this.group});
}

final class GroupDeleteEvent extends GroupEvent {
  final String groupId;

  GroupDeleteEvent({required this.groupId});
}

final class GroupGetEvent extends GroupEvent {
  final String groupId;

  GroupGetEvent({required this.groupId});
}

final class GroupsGetEvent extends GroupEvent {
  final String userId;

  GroupsGetEvent({required this.userId});
}

final class GroupAddMemberEvent extends GroupEvent {
  final GroupAddMemberParams params;

  GroupAddMemberEvent({required this.params});
}

final class GroupRemoveMemberEvent extends GroupEvent {
  final GroupRemoveMemberParams params;

  GroupRemoveMemberEvent({required this.params});
}
