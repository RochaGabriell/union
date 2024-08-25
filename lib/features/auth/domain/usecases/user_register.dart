/* Package Imports */
import 'package:fpdart/fpdart.dart';

/* Project Imports */
import 'package:union/features/auth/domain/repositories/auth_repository.dart';
import 'package:union/core/common/entities/user.dart';
import 'package:union/core/errors/failures.dart';
import 'package:union/core/usecase/usecase.dart';

class UserRegister implements UseCase<UserEntity, RegisterParams> {
  final AuthRepository _authRepository;

  UserRegister(this._authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(RegisterParams params) async {
    return await _authRepository.register(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class RegisterParams {
  final String name;
  final String email;
  final String password;

  RegisterParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
