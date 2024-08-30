/* Project Imports */
import 'package:union/features/group/data/repositories/group_repository_impl.dart';
import 'package:union/features/group/domain/repositories/group_repository.dart';
import 'package:union/features/group/domain/usecases/group_add_member.dart';
import 'package:union/features/group/domain/usecases/group_create.dart';
import 'package:union/features/group/domain/usecases/group_delete.dart';
import 'package:union/features/group/domain/usecases/group_get_group.dart';
import 'package:union/features/group/domain/usecases/group_get_groups.dart';
import 'package:union/features/group/domain/usecases/group_update.dart';
import 'package:union/features/group/presentation/bloc/group_bloc.dart';
import 'package:union/features/group/data/datasources/remote.dart';
import 'package:union/core/utils/injections.dart';

void initGroupInjections() {
  getIt
    ..registerFactory<GroupRemoteDataSource>(() {
      return GroupRemoteDataSourceImpl(getIt());
    })
    // Repositories
    ..registerFactory<GroupRepository>(() {
      return GroupRepositoryImpl(
        getIt(),
        getIt(),
      );
    })
    // Use cases
    ..registerFactory(() => GroupCreate(getIt()))
    ..registerFactory(() => GroupUpdate(getIt()))
    ..registerFactory(() => GroupDelete(getIt()))
    ..registerFactory(() => GroupGetGroup(getIt()))
    ..registerFactory(() => GroupGetGroups(getIt()))
    ..registerFactory(() => GroupAddMember(getIt()))
    // Bloc
    ..registerLazySingleton(() {
      return GroupBloc(
        groupCreate: getIt(),
        groupUpdate: getIt(),
        groupDelete: getIt(),
        groupGetGroup: getIt(),
        groupGetGroups: getIt(),
        groupAddMember: getIt(),
      );
    });
}
