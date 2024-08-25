/* Package Imports */
import 'package:fpdart/fpdart.dart';

/* Project Imports */
import 'package:union/core/errors/failures.dart';

abstract interface class GroupCase<SuccesType, Params> {
  Future<Either<Failure, SuccesType>> call(Params params);
}

class NoParams {}
