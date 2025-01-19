import 'package:blogapp/core/error/failures.dart';
import 'package:blogapp/feature/auth/domain/entity/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> signInWithEmailPassword({
    required String email,
    required String password,
  });
}
