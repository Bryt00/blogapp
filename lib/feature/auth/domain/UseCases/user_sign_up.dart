import 'package:blogapp/core/error/failures.dart';
import 'package:blogapp/feature/auth/domain/entity/user.dart';
import 'package:blogapp/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/use_case/usecase.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;

  const UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
        name: params.name, email: params.email, password: params.password);
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String name;

  UserSignUpParams(
      {required this.name, required this.email, required this.password});
}
