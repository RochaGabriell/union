/* Package Imports */
import 'package:union/features/group/domain/entities/group_entity.dart';
import 'package:union/features/group/data/models/group.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

/* Project Imports */
import 'package:union/features/group/domain/repositories/group_repository.dart';
import 'package:union/features/group/data/datasources/remote.dart';
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

  @override
  Future<Either<Failure, String>> createGroup({
    required GroupEntity group,
  }) async {
    try {
      if (!await _isConnected()) {
        return left(Failure(Constants.noConnectionMessage));
      }

      final groupModel = GroupModel(
        id: const Uuid().v4(),
        name: group.name,
        creatorId: group.creatorId,
        members: group.members,
      );

      final result = await _groupRemoteDataSource.createGroup(
        group: groupModel,
      );

      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateGroup({
    required GroupEntity group,
  }) async {
    try {
      if (!await _isConnected()) {
        return left(Failure(Constants.noConnectionMessage));
      }

      final groupModel = GroupModel(
        id: group.id,
        name: group.name,
        creatorId: group.creatorId,
        members: group.members,
      );

      await _groupRemoteDataSource.updateGroup(group: groupModel);

      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteGroup({required String groupId}) async {
    try {
      if (!await _isConnected()) {
        return left(Failure(Constants.noConnectionMessage));
      }

      await _groupRemoteDataSource.deleteGroup(groupId: groupId);
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, GroupEntity>> getGroup({
    required String groupId,
  }) async {
    try {
      if (!await _isConnected()) {
        return left(Failure(Constants.noConnectionMessage));
      }

      final groupModel = await _groupRemoteDataSource.getGroup(
        groupId: groupId,
      );

      final groupEntity = GroupEntity(
        id: groupModel.id,
        name: groupModel.name,
        creatorId: groupModel.creatorId,
        members: groupModel.members,
      );

      return right(groupEntity);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, List<GroupEntity>>> getGroups({
    required String userId,
  }) async {
    try {
      if (!await _isConnected()) {
        return left(Failure(Constants.noConnectionMessage));
      }

      final groupModels = await _groupRemoteDataSource.getGroups(
        userId: userId,
      );

      final groupEntities = groupModels.map((model) {
        return GroupEntity(
          id: model.id,
          name: model.name,
          creatorId: model.creatorId,
          members: model.members,
        );
      }).toList();

      return right(groupEntities);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure('Unexpected error: $e'));
    }
  }
}
