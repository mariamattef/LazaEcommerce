import 'package:dartz/dartz.dart';
import 'package:laza_ecommerce/core/errors/failure.dart';
import 'package:laza_ecommerce/features/auth/domain/repos/user_repository.dart';

class AuthUsecase {
 final UserRepository userRepository;

  AuthUsecase({required this.userRepository});

   Future<Either<Failure, Unit>> callRegister({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    return await userRepository.signUp(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
  }

    Future<Either<Failure, Unit>> callSignin({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    return await userRepository.signIn(email: email, password: password, rememberMe: rememberMe);
  }

}
