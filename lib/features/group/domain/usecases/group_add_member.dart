/* Package Imports */
import 'package:fpdart/fpdart.dart';

/* Project Imports */
import 'package:union/features/group/domain/repositories/group_repository.dart';
import 'package:union/core/usecase/usecase.dart';
import 'package:union/core/errors/failures.dart';

class GroupAddMember implements UseCase<void, GroupAddMemberParams> {
  final GroupRepository _groupRepository;

  GroupAddMember(this._groupRepository);

  @override
  Future<Either<Failure, void>> call(GroupAddMemberParams params) async {
    return await _groupRepository.addMember(
      groupId: params.groupId,
      userId: params.userId,
    );
  }
}

class GroupAddMemberParams {
  final String groupId;
  final String userId;

  GroupAddMemberParams({
    required this.groupId,
    required this.userId,
  });
}
