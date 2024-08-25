/* Package Imports */
import 'package:fpdart/fpdart.dart';

/* Project Imports */
import 'package:union/features/profile/domain/entities/profile_entity.dart';
import 'package:union/core/errors/failures.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getCurrentProfile();

  Future<Either<Failure, ProfileEntity>> updateProfile({
    required double fixedIncome,
    required int type,
  });
}
