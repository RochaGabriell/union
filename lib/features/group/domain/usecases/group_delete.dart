/* Package Imports */
import 'package:fpdart/fpdart.dart';

/* Project Imports */
import 'package:union/features/group/domain/repositories/group_repository.dart';
import 'package:union/features/group/domain/usecases/groupcase.dart';
import 'package:union/core/errors/failures.dart';

class GroupDelete implements GroupCase<void, String> {
  final GroupRepository _groupRepository;

  GroupDelete(this._groupRepository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await _groupRepository.deleteGroup(groupId: params);
  }
}
