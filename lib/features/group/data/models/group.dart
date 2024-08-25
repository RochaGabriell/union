import 'package:union/features/group/domain/entities/group_entity.dart';

class GroupModel extends GroupEntity {
  GroupModel({
    super.id,
    required super.creatorId,
    required super.name,
    required super.description,
    required super.members,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    final members = json['members'];
    final membersList = members != null ? List<String>.from(members) : [];

    return GroupModel(
      id: json['id'],
      creatorId: json['creatorId'],
      name: json['name'],
      description: json['description'],
      members: membersList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creatorId': creatorId,
      'name': name,
      'description': description,
      'members': members,
    };
  }
}
