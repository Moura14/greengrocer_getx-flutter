const String baseUrl = 'https://parseapi.back4app.com/functions/';

abstract class Endpoint {
  static const String signIn = '$baseUrl/login';
  static const String signUp = '$baseUrl/signup';
  static const String validateToken = '$baseUrl/validate-token';
}
