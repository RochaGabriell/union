/* Package Imports */
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

/* Core Imports */
import 'package:union/core/common/cubit/user/user_cubit.dart';
import 'package:union/core/network/connection_checker.dart';

/* Feature Imports */
import 'package:union/features/group/group_injections.dart';
import 'package:union/features/auth/auth_injections.dart';
import 'package:union/core/themes/bloc/theme_bloc.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  initAuthInjections();
  initGroupInjections();

  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);

  getIt.registerLazySingleton(() => ThemeBloc());

  getIt.registerLazySingleton(() => UserCubit());

  getIt.registerFactory<Connectivity>(() => Connectivity());

  getIt.registerFactory<ConnectionChecker>(() {
    return ConnectionCheckerImpl(getIt());
  });
}
