/* Package Imports */
import 'package:fpdart/fpdart.dart';

/* Project Imports */
import 'package:union/features/group/domain/entities/group_entity.dart';
import 'package:union/core/errors/failures.dart';

abstract interface class GroupRepository {
  Future<Either<Failure, String>> createGroup({required GroupEntity group});

  Future<Either<Failure, void>> updateGroup({required GroupEntity group});

  Future<Either<Failure, void>> deleteGroup({required String groupId});

  Future<Either<Failure, GroupEntity>> getGroup({required String groupId});

  Future<Either<Failure, List<GroupEntity>>> getGroups({
    required String userId,
  });

  Future<Either<Failure, void>> addMember({
    required String groupId,
    required String userId,
  });
}
