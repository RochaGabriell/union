class GroupEntity {
  final String? id;
  final String creatorId;
  final String name;
  final String description;
  final List<dynamic> members;

  GroupEntity({
    this.id,
    required this.creatorId,
    required this.name,
    required this.description,
    required this.members,
  });
}
