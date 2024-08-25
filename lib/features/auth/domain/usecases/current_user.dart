/* Package Imports */
import 'package:fpdart/fpdart.dart';

/* Project Imports */
import 'package:union/features/auth/domain/repositories/auth_repository.dart';
import 'package:union/core/common/entities/user.dart';
import 'package:union/core/errors/failures.dart';
import 'package:union/core/usecase/usecase.dart';

class CurrentUser implements UseCase<UserEntity, NoParams> {
  final AuthRepository _authRepository;

  CurrentUser(this._authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await _authRepository.getCurrentUser();
  }
}
