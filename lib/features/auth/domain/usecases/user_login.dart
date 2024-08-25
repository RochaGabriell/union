/* Package Imports */
import 'package:fpdart/fpdart.dart';

/* Project Imports */
import 'package:union/features/auth/domain/repositories/auth_repository.dart';
import 'package:union/core/common/entities/user.dart';
import 'package:union/core/errors/failures.dart';
import 'package:union/core/usecase/usecase.dart';

class UserLogin implements UseCase<UserEntity, LoginParams> {
  final AuthRepository _authRepository;

  UserLogin(this._authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) async {
    return await _authRepository.login(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
