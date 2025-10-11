import 'package:dartz/dartz.dart';
import 'package:laza_ecommerce/core/errors/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, Unit>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });
  Future<Either<Failure, Unit>> signIn({required String email, required String password, required bool rememberMe});

  Future<Either<Failure, Unit>> verifyOtp(
      {required String email, required String otp});

  Future<Either<Failure, Unit>> logout();
}
