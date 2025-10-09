class EndPoints {
  static const String baserUrl = "https://accessories-eshop.runasp.net";
  static const String register = "/api/auth/register";
  static const String login = "/api/auth/login";
  static const String getProducts = "/api/products";
  static const String getCategories = "/api/categories";
  static const String refreshToken = "/api/auth/refresh-token";
  static const String validateOtp = "/api/auth/validate-otp";
}

class ApiKey {
  static String email = "email";
  static String password = "password";
  static String firstname = "firstName";
  static String lastname = "lastName";
}
