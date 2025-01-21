//import 'package:blogapp/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blogapp/core/use_case/usecase.dart';
import 'package:blogapp/feature/auth/domain/UseCases/current_user.dart';
import 'package:blogapp/feature/auth/domain/UseCases/user_sign_up.dart';
import 'package:blogapp/feature/auth/domain/UseCases/user_signin.dart';
import 'package:blogapp/core/common/entity/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required CurrentUser currentUser,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _currentUser = currentUser,
        super(AuthInitial()) {
    on<AuthSignUpEvent>(_onAuthSignUp);
    on<AuthSignInEvent>(_onAuthSignIn);
    on<AuthCurrentUser>(_onAuthCurrentUser);
    on<AppUserSignedInEvent>(_onAppUserSignedIn);
  }

  void _onAuthSignUp(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final res = await _userSignUp(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    res.fold(
      (failure) =>
          emit(AuthFailureState(failure.msg)), //l (Failure) is of type Failure
      (r) {
        print(r);
        _emitAuthSuccess(r, emit);
      },
    ); //r is of type User
  }

  void _onAuthSignIn(AuthSignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final res = await _userSignIn(
        UserSignInParams(email: event.email, password: event.password));
    res.fold((failure) => emit(AuthFailureState(failure.msg)), (r) {
      print(r);
      _emitAuthSuccess(r, emit);
    });
  }

  void _onAppUserSignedIn(AppUserSignedInEvent event, Emitter<AuthState> emit) {
    emit(AppUserSignedInState(event.user));
  }

  void _onAuthCurrentUser(
      AuthCurrentUser event, Emitter<AuthState> emit) async {
    final res = await _currentUser(EmptyParams());

    res.fold((l) => emit(AuthFailureState(l.msg)), (user) {
      print(
        user.id,
      );
      _emitAuthSuccess(user, emit);
    });
  }

  void _emitAuthSuccess(User? user, Emitter<AuthState> emit) {
    emit(AuthSuccessState(user!));
  }
}
