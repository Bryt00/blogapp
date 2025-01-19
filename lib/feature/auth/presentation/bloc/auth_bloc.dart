import 'package:blogapp/feature/auth/domain/UseCases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;

  AuthBloc({
    required userSignUp,
  })  : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthSignUpEvent>(
      (event, emit) async {
        final res = await _userSignUp(
          UserSignUpParams(
            name: event.name,
            email: event.email,
            password: event.password,
          ),
        );
        res.fold(
            (l) => emit(AuthFailureState(l.msg)), //l is of type Failure
            (r) => emit(AuthSuccessState(r))); //r is a string
      },
    );
  }

  _signUp() {}
}
