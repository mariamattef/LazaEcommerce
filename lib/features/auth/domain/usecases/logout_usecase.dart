import 'package:dartz/dartz.dart';
import 'package:laza_ecommerce/core/errors/failure.dart';
import 'package:laza_ecommerce/features/auth/domain/repos/user_repository.dart';

class LogoutUseCase {
  final UserRepository userRepository;

  LogoutUseCase({required this.userRepository});

  Future<Either<Failure, Unit>> call() async {
    return await userRepository.logout();
  }
}
