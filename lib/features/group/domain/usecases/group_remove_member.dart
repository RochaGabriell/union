/* Package Imports */
import 'package:fpdart/fpdart.dart';

/* Project Imports */
import 'package:union/features/group/domain/repositories/group_repository.dart';
import 'package:union/core/usecase/usecase.dart';
import 'package:union/core/errors/failures.dart';

class GroupRemoveMember implements UseCase<void, GroupRemoveMemberParams> {
  final GroupRepository _groupRepository;

  GroupRemoveMember(this._groupRepository);

  @override
  Future<Either<Failure, void>> call(GroupRemoveMemberParams params) async {
    return await _groupRepository.removeMember(
      groupId: params.groupId,
      userId: params.userId,
    );
  }
}

class GroupRemoveMemberParams {
  final String groupId;
  final String userId;

  GroupRemoveMemberParams({
    required this.groupId,
    required this.userId,
  });
}
