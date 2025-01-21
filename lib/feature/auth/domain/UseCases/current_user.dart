import 'package:blogapp/core/error/failures.dart';
import 'package:blogapp/core/use_case/usecase.dart';
import 'package:blogapp/core/common/entity/user.dart';
import 'package:blogapp/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<User, EmptyParams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);
  @override
  Future<Either<Failure, User>> call(EmptyParams params) async {
    return authRepository.currentUser();
  }
}
