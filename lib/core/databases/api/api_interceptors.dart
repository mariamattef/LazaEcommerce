import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] =
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJlZGMzZTVkNi0xMmRiLTRiZmYtNTM4MC0wOGRlMDQ4NTRkODkiLCJqdGkiOiI5Y2U3ZjNmNi1jY2M1LTRkMTAtODhkOS04MDgxZWRmMTI3M2YiLCJlbWFpbCI6Im1hcmlhbWF0dGVmNjU2QGdtYWlsLmNvbSIsIm5hbWUiOiJNYXJpYW0gYXR0ZWYiLCJyb2xlcyI6IiIsInBpY3R1cmUiOiIiLCJleHAiOjE3NjAwNDgyOTAsImlzcyI6ImVzaG9wLm5ldCIsImF1ZCI6ImVzaG9wLm5ldCJ9.XUZHQcS5wk9x0RXdW4V7TETd5kBFstsfk_SspLXx3og';
    print('Authorization Header: ${options.headers['Authorization']}');
    super.onRequest(options, handler);
  }
}
