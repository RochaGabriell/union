/* Package Imports */
import 'package:fpdart/fpdart.dart';

/* Project Imports */
import 'package:union/features/auth/domain/repositories/auth_repository.dart';
import 'package:union/features/auth/data/datasources/remote.dart';
import 'package:union/core/network/connection_checker.dart';
import 'package:union/core/common/entities/user.dart';
import 'package:union/core/constants/constants.dart';
import 'package:union/core/errors/exceptions.dart';
import 'package:union/core/errors/failures.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final ConnectionChecker _connectionChecker;

  const AuthRepositoryImpl(
    this._authRemoteDataSource,
    this._connectionChecker,
  );

  Future<bool> _isConnected() async {
    return await _connectionChecker.connected;
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      if (!await _isConnected()) {
        final user = await _authRemoteDataSource.getCurrentUserData();
        if (user == null) {
          return left(Failure(Constants.noConnectionMessage));
        }
        return right(user);
      }
      final user = await _authRemoteDataSource.getCurrentUserData();

      if (user == null) {
        return left(Failure('Usuário não logado'));
      }

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    return _getUserEntity(() async {
      return await _authRemoteDataSource.login(
        email: email,
        password: password,
      );
    });
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String name,
    required String password,
  }) async {
    return _getUserEntity(() async {
      return await _authRemoteDataSource.register(
        email: email,
        name: name,
        password: password,
      );
    });
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      if (!await _isConnected()) {
        return left(Failure(Constants.noConnectionMessage));
      }
      await _authRemoteDataSource.logout();

      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  Future<Either<Failure, UserEntity>> _getUserEntity(
    Future<UserEntity> Function() getUser,
  ) async {
    try {
      if (!await _isConnected()) {
        return left(Failure(Constants.noConnectionMessage));
      }

      final user = await getUser();

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
