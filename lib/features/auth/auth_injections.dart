/* Package Imports */
import 'package:union/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:union/features/auth/domain/repositories/auth_repository.dart';
import 'package:union/features/auth/domain/usecases/user_register.dart';
import 'package:union/features/auth/domain/usecases/current_user.dart';
import 'package:union/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:union/features/auth/domain/usecases/user_logout.dart';
import 'package:union/features/auth/domain/usecases/user_login.dart';
import 'package:union/features/auth/data/datasources/remote.dart';
import 'package:union/core/utils/injections.dart';

void initAuthInjections() {
  getIt
    ..registerFactory<AuthRemoteDataSource>(() {
      return AuthRemoteDataSourceImpl(getIt());
    })
    // Repositories
    ..registerFactory<AuthRepository>(() {
      return AuthRepositoryImpl(
        getIt(),
        getIt(),
      );
    })
    // Use cases
    ..registerFactory(() => UserLogin(getIt()))
    ..registerFactory(() => UserRegister(getIt()))
    ..registerFactory(() => UserLogout(getIt()))
    ..registerFactory(() => CurrentUser(getIt()))
    // Bloc
    ..registerLazySingleton(() {
      return AuthBloc(
        userLogin: getIt(),
        userRegister: getIt(),
        currentUser: getIt(),
        userLogout: getIt(),
        userCubit: getIt(),
      );
    });
}
