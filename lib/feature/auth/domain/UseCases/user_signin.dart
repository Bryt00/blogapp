import 'package:blogapp/core/error/failures.dart';
import 'package:blogapp/core/use_case/usecase.dart';
import 'package:blogapp/feature/auth/domain/entity/user.dart';
import 'package:blogapp/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserSignIn implements UseCase<User, UserSignInParams> {
  final AuthRepository authRepository;

  UserSignIn(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignInParams params) async {
    return authRepository.signInWithEmailPassword(
        email: params.email, password: params.password);
  }
}

class UserSignInParams {
  final String password;
  final String email;
  UserSignInParams({required this.email, required this.password});
}
