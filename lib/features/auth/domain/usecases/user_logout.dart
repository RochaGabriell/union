/* Package Imports */
import 'package:fpdart/fpdart.dart';

/* Project Imports */
import 'package:union/features/auth/domain/repositories/auth_repository.dart';
import 'package:union/core/errors/failures.dart';
import 'package:union/core/usecase/usecase.dart';

class UserLogout implements UseCase<void, NoParams> {
  final AuthRepository _authRepository;

  UserLogout(this._authRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await _authRepository.logout();
  }
}
