/* Package Imports */
import 'package:fpdart/fpdart.dart';

/* Project Imports */
import 'package:union/features/group/domain/repositories/group_repository.dart';
import 'package:union/features/group/domain/entities/group_entity.dart';
import 'package:union/features/group/domain/usecases/groupcase.dart';
import 'package:union/core/errors/failures.dart';

class GroupGetGroups implements GroupCase<List<GroupEntity>, String> {
  final GroupRepository _groupRepository;

  GroupGetGroups(this._groupRepository);

  @override
  Future<Either<Failure, List<GroupEntity>>> call(String params) async {
    return await _groupRepository.getGroups(userId: params);
  }
}
