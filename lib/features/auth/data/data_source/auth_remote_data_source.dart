import 'package:dio/dio.dart';
import 'package:laza_ecommerce/core/errors/error_model.dart';
import 'package:laza_ecommerce/core/errors/exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<Response> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });
  Future<Response> signIn({required String email, required String password});
  Future<Response> verifyOtp({required String email, required String otp});
  Future<Response> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<Response> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final response = await dio.post(
        'https://accessories-eshop.runasp.net/api/auth/register',
        data: {
          'email': email,
          'password': password,
          'firstName': firstName,
          'lastName': lastName,
        },
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400 &&
          e.response?.data.toString().contains('Email is already in use') == true) {
        throw EmailAlreadyInUseException(
            ErrorModel(errorMessage: 'Email is already in use'));
      }
      handleDioException(e);
      throw ServerException(ErrorModel(
          errorMessage: 'An unexpected error occurred', status: 500));
    }
  }

  @override
  Future<Response> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        'https://accessories-eshop.runasp.net/api/auth/login',
        data: {'email': email, 'password': password},
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw InvalidCredentialsException(
            ErrorModel(errorMessage: 'Invalid credentials'));
      }
      handleDioException(e);
      throw ServerException(ErrorModel(
          errorMessage: 'An unexpected error occurred', status: 500));
    }
  }

  @override
  Future<Response> verifyOtp({required String email, required String otp}) async {
    try {
      final response = await dio.post(
        'https://accessories-eshop.runasp.net/api/auth/verify-otp',
        data: {'email': email, 'otp': otp},
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw InvalidOtpException(ErrorModel(errorMessage: 'Invalid OTP'));
      }
      handleDioException(e);
      throw ServerException(ErrorModel(
          errorMessage: 'An unexpected error occurred', status: 500));
    }
  }

  @override
  Future<Response> logout() async {
    try {
      final response = await dio.post(
        'https://accessories-eshop.runasp.net/api/auth/logout',
      );
      return response;
    } on DioException catch (e) {
      handleDioException(e);
      throw ServerException(ErrorModel(
          errorMessage: 'An unexpected error occurred', status: 500));
    }
  }
}
