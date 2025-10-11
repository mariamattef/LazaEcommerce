import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce/features/auth/domain/usecases/auth_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUsecase authUsecase;

  AuthCubit({required this.authUsecase}) : super(AuthInitial());

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
      (failure) => emit(AuthFailure(errMessage: failure.message)),
      (_) => emit(AuthSuccess()),
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
      (failure) => emit(AuthFailure(errMessage: failure.message)),
      (_) => emit(AuthSuccess()),
    );
  }
}
