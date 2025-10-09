import 'dart:convert';

import 'package:dartz/dartz.dart';
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
    } catch (e) {
      return left(
        Failure(errMessage: e.toString().replaceAll('Exception: ', ' ')),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await authRemoteDataSource.signIn(
        email: email,
        password: password,
      );

      final prefs = await SharedPreferences.getInstance();

      // Safely parse the response data
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

      return right(unit);
    } catch (e) {
      return left(
        Failure(errMessage: e.toString().replaceAll('Exception: ', '')),
      );
    }
  }
}
