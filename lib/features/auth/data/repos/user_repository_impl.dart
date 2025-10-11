import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:laza_ecommerce/core/errors/exceptions.dart';
import 'package:laza_ecommerce/core/errors/failure.dart';
import 'package:laza_ecommerce/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:laza_ecommerce/features/auth/domain/repos/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepositoryImpl implements UserRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  UserRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, Unit>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      await authRemoteDataSource.signUp(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );
      return right(unit);
    } on EmailAlreadyInUseException catch (e) {
      return left(ServerFailure(e.errorModel.errorMessage));
    } on ServerException catch (e) {
      return left(ServerFailure(e.errorModel.errorMessage));
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
  @override
  Future<Either<Failure, Unit>> signIn({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    try {
      final response = await authRemoteDataSource.signIn(
        email: email,
        password: password,
      );

      if (rememberMe) {
        final prefs = await SharedPreferences.getInstance();
        Map<String, dynamic> responseData;
        if (response.data is String) {
          responseData = jsonDecode(response.data) as Map<String, dynamic>;
        } else if (response.data is Map<String, dynamic>) {
          responseData = response.data;
        } else {
          throw Exception('Unexpected response format from server');
        }

        final accessToken = responseData['accessToken'];
        final refreshToken = responseData['refreshToken'];

        if (accessToken != null && refreshToken != null) {
          await prefs.setString('token', accessToken);
          await prefs.setString('refresh_token', refreshToken);
        } else {
          throw Exception('Tokens not found in response');
        }
      }

      return right(unit);
    } on InvalidCredentialsException catch (e) {
      return left(ServerFailure(e.errorModel.errorMessage));
    } on ServerException catch (e) {
      return left(ServerFailure(e.errorModel.errorMessage));
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyOtp(
      {required String email, required String otp}) async {
    try {
      await authRemoteDataSource.verifyOtp(email: email, otp: otp);
      return right(unit);
    } on InvalidOtpException catch (e) {
      return left(ServerFailure(e.errorModel.errorMessage));
    } on ServerException catch (e) {
      return left(ServerFailure(e.errorModel.errorMessage));
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await authRemoteDataSource.logout();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('refresh_token');
      return right(unit);
    } on ServerException catch (e) {
      return left(ServerFailure(e.errorModel.errorMessage));
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
