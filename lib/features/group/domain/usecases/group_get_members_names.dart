/* Package Imports */
import 'package:fpdart/fpdart.dart';

/* Project Imports */
import 'package:union/features/group/domain/repositories/group_repository.dart';
import 'package:union/core/usecase/usecase.dart';
import 'package:union/core/errors/failures.dart';

class GroupGetMembersNames implements UseCase<List<String>, String> {
  final GroupRepository _groupRepository;

  GroupGetMembersNames(this._groupRepository);

  @override
  Future<Either<Failure, List<String>>> call(String groupId) async {
    return await _groupRepository.getMembersNames(groupId: groupId);
  }
}
