import 'package:dio/dio.dart';
import 'package:laza_ecommerce/core/databases/api/end_points.dart';
import 'package:laza_ecommerce/core/di/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refresh_token');

      if (refreshToken != null) {
        try {
          final dio = Dio(BaseOptions(baseUrl: EndPoints.baserUrl));
          final response = await dio.post(
            EndPoints.refreshToken,
            data: {'refreshToken': refreshToken},
          );

          if (response.statusCode == 200) {
            final newAccessToken = response.data['accessToken'];
            await prefs.setString('token', newAccessToken);

            err.requestOptions.headers['Authorization'] =
                'Bearer $newAccessToken';
            final opts = Options(
              method: err.requestOptions.method,
              headers: err.requestOptions.headers,
            );
            final cloneReq = await sl<Dio>().request(
              err.requestOptions.path,
              options: opts,
              data: err.requestOptions.data,
              queryParameters: err.requestOptions.queryParameters,
            );

            return handler.resolve(cloneReq);
          }
        } catch (e) {
          // If refresh fails, clear tokens and let the error proceed.
          await prefs.remove('token');
          await prefs.remove('refresh_token');
        }
      }
    }
    super.onError(err, handler);
  }
}
