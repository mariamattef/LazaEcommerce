import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  Future<Response> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });
  Future<Response> signIn({required String email, required String password});
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
      if (e.response != null) {
        print("Error in signUp: ${e.response}");
        throw Exception(
          e.response?.data['errors']?['email']?[0] ??
              e.response?.data['message'] ??
              'An error occurred',
        );
      } else {
        print("Error in signUp: ${e.message}");
        throw Exception('Network Error: Please check your internet connection and try again.');
      }
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
      if (e.response != null) {
        print("Error in signIn: ${e.response}");
        throw Exception(e.response?.data['message'] ?? 'An error occurred');
      } else {
        print("Error in signIn: ${e.message}");
        throw Exception('Network Error: Please check your internet connection and try again.');
      }
    }
  }
}
