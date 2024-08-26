/* Package Imports */
import 'package:fpdart/fpdart.dart';
import 'package:union/features/group/domain/entities/group_entity.dart';

/* Project Imports */
import 'package:union/features/group/domain/repositories/group_repository.dart';
import 'package:union/core/usecase/usecase.dart';
import 'package:union/core/errors/failures.dart';

class GroupUpdate implements UseCase<void, GroupEntity> {
  final GroupRepository _groupRepository;

  GroupUpdate(this._groupRepository);

  @override
  Future<Either<Failure, void>> call(GroupEntity params) async {
    return await _groupRepository.updateGroup(group: params);
  }
}
