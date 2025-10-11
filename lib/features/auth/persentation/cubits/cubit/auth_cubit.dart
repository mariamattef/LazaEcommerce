import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce/features/auth/domain/usecases/auth_usecase.dart';
import 'package:laza_ecommerce/features/auth/domain/usecases/logout_usecase.dart';
import 'package:laza_ecommerce/features/auth/domain/usecases/verify_otp_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUsecase authUsecase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final LogoutUseCase logoutUseCase;

  AuthCubit({
    required this.authUsecase,
    required this.verifyOtpUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial());

  Future<void> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    emit(AuthLoading());
    final result = await authUsecase.callRegister(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
    result.fold(
      (failure) => emit(AuthFailure(errMessage: failure.errorMessage)),
      (_) => emit(AuthSignUpSuccess(email: email)),
    );
  }

  Future<void> signIn({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    emit(AuthLoading());
    final result = await authUsecase.callSignin(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );
    result.fold(
      (failure) => emit(AuthFailure(errMessage: failure.errorMessage)),
      (_) => emit(AuthSuccess()),
    );
  }

  Future<void> verifyOtp({required String email, required String otp}) async {
    emit(OtpVerificationLoading());
    final result = await verifyOtpUseCase.call(
      email: email,
      otp: otp,
    );
    result.fold(
      (failure) => emit(OtpVerificationFailure(errMessage: failure.errorMessage)),
      (_) => emit(OtpVerificationSuccess()),
    );
  }

  Future<void> logout() async {
    emit(LogoutLoading());
    final result = await logoutUseCase.call();
    result.fold(
      (failure) => emit(LogoutFailure(errMessage: failure.errorMessage)),
      (_) => emit(LogoutSuccess()),
    );
  }
}
