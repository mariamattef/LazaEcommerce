import 'package:dartz/dartz.dart';
import 'package:laza_ecommerce/core/errors/failure.dart';
import 'package:laza_ecommerce/features/auth/domain/repos/user_repository.dart';

class VerifyOtpUseCase {
  final UserRepository userRepository;

  VerifyOtpUseCase({required this.userRepository});

  Future<Either<Failure, Unit>> call({
    required String email,
    required String otp,
  }) async {
    return await userRepository.verifyOtp(
      email: email,
      otp: otp,
    );
  }
}
