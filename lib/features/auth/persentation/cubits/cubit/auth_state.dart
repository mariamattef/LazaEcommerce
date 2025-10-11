part of 'auth_cubit.dart';

abstract class AuthState {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}



class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthSignUpSuccess extends AuthState {
  final String email;

  const AuthSignUpSuccess({required this.email});

  @override
  List<Object> get props => [email];
}

class AuthFailure extends AuthState {
  final String errMessage;

  const AuthFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}




class OtpVerificationLoading extends AuthState {}

class OtpVerificationSuccess extends AuthState {}

class OtpVerificationFailure extends AuthState {
  final String errMessage;

  const OtpVerificationFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}





class LogoutLoading extends AuthState {}

class LogoutSuccess extends AuthState {}

class LogoutFailure extends AuthState {
  final String errMessage;

  const LogoutFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}
