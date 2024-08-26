/* Package Imports */
import 'package:fpdart/fpdart.dart';

/* Project Imports */
import 'package:union/features/group/domain/repositories/group_repository.dart';
import 'package:union/features/group/domain/entities/group_entity.dart';
import 'package:union/core/usecase/usecase.dart';
import 'package:union/core/errors/failures.dart';

class GroupCreate implements UseCase<String, GroupEntity> {
  final GroupRepository _groupRepository;

  GroupCreate(this._groupRepository);

  @override
  Future<Either<Failure, String>> call(GroupEntity params) async {
    return await _groupRepository.createGroup(group: params);
  }
}
