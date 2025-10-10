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
        throw Exception(_parseDioError(e));
      } else {
        print("Error in signUp: ${e.message}");
        throw Exception(
            'Network Error: Please check your internet connection and try again.');
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
        throw Exception(_parseDioError(e));
      } else {
        print("Error in signIn: ${e.message}");
        throw Exception(
            'Network Error: Please check your internet connection and try again.');
      }
    }
  }

  String _parseDioError(DioException e) {
    final responseData = e.response?.data;
    if (responseData == null) return 'An unknown error occurred.';

    // Handle structured validation errors
    if (responseData is Map<String, dynamic> &&
        responseData.containsKey('errors')) {
      final errors = responseData['errors'] as Map<String, dynamic>;
      return errors.entries
          .map((entry) => '${entry.key}: ${(entry.value as List).join(', ')}')
          .join('\n');
    }

    // Handle simple message errors
    return responseData['message']?.toString() ?? e.message ?? 'An error occurred';
  }
}
