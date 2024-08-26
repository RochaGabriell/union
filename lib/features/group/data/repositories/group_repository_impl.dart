/* Package Imports */
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

/* Project Imports */
import 'package:union/features/group/domain/repositories/group_repository.dart';
import 'package:union/features/group/domain/entities/group_entity.dart';
import 'package:union/features/group/data/datasources/remote.dart';
import 'package:union/features/group/data/models/group.dart';
import 'package:union/core/network/connection_checker.dart';
import 'package:union/core/constants/constants.dart';
import 'package:union/core/errors/exceptions.dart';
import 'package:union/core/errors/failures.dart';

class GroupRepositoryImpl implements GroupRepository {
  final GroupRemoteDataSource _groupRemoteDataSource;
  final ConnectionChecker _connectionChecker;

  GroupRepositoryImpl(
    this._groupRemoteDataSource,
    this._connectionChecker,
  );

  Future<bool> _isConnected() async {
    return await _connectionChecker.connected;
  }

  Future<Either<Failure, T>> _performRemoteOperation<T>(
    Future<T> Function() operation,
  ) async {
    if (!await _isConnected()) {
      return left(Failure(Constants.noConnectionMessage));
    }
    try {
      final result = await operation();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure('Unexpected error: $e'));
    }
  }

  GroupModel _mapEntityToModel(GroupEntity group) {
    return GroupModel(
      id: const Uuid().v4(),
      name: group.name,
      description: group.description,
      creatorId: group.creatorId,
      members: group.members,
    );
  }

  @override
  Future<Either<Failure, String>> createGroup({
    required GroupEntity group,
  }) async {
    return await _performRemoteOperation(() async {
      final groupModel = _mapEntityToModel(group);
      return await _groupRemoteDataSource.createGroup(group: groupModel);
    });
  }

  @override
  Future<Either<Failure, void>> updateGroup({
    required GroupEntity group,
  }) async {
    return await _performRemoteOperation(() async {
      final groupModel = _mapEntityToModel(group);
      await _groupRemoteDataSource.updateGroup(group: groupModel);
      return;
    });
  }

  @override
  Future<Either<Failure, void>> deleteGroup({required String groupId}) async {
    return await _performRemoteOperation(() async {
      await _groupRemoteDataSource.deleteGroup(groupId: groupId);
      return;
    });
  }

  @override
  Future<Either<Failure, GroupEntity>> getGroup({
    required String groupId,
  }) async {
    return await _performRemoteOperation(() async {
      final groupModel = await _groupRemoteDataSource.getGroup(
        groupId: groupId,
      );
      return GroupEntity(
        id: groupModel.id,
        name: groupModel.name,
        description: groupModel.description,
        creatorId: groupModel.creatorId,
        members: groupModel.members,
      );
    });
  }

  @override
  Future<Either<Failure, List<GroupEntity>>> getGroups({
    required String userId,
  }) async {
    return await _performRemoteOperation(() async {
      final groups = await _groupRemoteDataSource.getGroups(userId: userId);
      return groups.map((group) {
        return GroupEntity(
          id: group.id,
          name: group.name,
          description: group.description,
          creatorId: group.creatorId,
          members: group.members,
        );
      }).toList();
    });
  }
}
