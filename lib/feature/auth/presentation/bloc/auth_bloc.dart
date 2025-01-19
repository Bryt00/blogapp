import 'package:blogapp/feature/auth/domain/UseCases/user_sign_up.dart';
import 'package:blogapp/feature/auth/domain/UseCases/user_signin.dart';
import 'package:blogapp/feature/auth/domain/entity/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        super(AuthInitial()) {
    on<AuthSignUpEvent>(_onAuthSignUp);
    on<AuthSignInEvent>(_onAuthSignIn);
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
      (user) => emit(
        AuthSuccessState(user),
      ),
    ); //r (uid) is a string
  }

  void _onAuthSignIn(AuthSignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final res = await _userSignIn(
        UserSignInParams(email: event.email, password: event.password));
    res.fold(
      (failure) => emit(AuthFailureState(failure.msg)),
      (user) => emit(
        AuthSuccessState(
          user,
        ),
      ),
    );
  }
}
