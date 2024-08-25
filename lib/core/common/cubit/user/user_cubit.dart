/* Flutter Imports */
import 'package:flutter/material.dart';

/* Package Imports */
import 'package:flutter_bloc/flutter_bloc.dart';

/* Project Imports */
import 'package:union/core/common/entities/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  // Ao usar super, o estado inicial é UserInitialState
  UserCubit() : super(UserInitialState());

  void update(UserEntity? user) {
    if (user != null) {
      emit(UserLoggedInState(user));
    } else {
      emit(UserInitialState());
    }
  }

  // Pegar o usuário logado
  UserEntity? get user {
    if (state is UserLoggedInState) {
      return (state as UserLoggedInState).user;
    }
    return null;
  }
}
