part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;

  AuthSignUpEvent(
      {required this.email, required this.password, required this.name});
}

final class AuthSignInEvent extends AuthEvent {
  final String email;
  final String password;
  AuthSignInEvent({required this.email, required this.password});
}

final class AuthCurrentUser extends AuthEvent {}

final class AppUserSignedInEvent extends AuthEvent {
  final User user;
  AppUserSignedInEvent(this.user);
}
