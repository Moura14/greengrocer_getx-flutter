const String baseUrl = 'https://parseapi.back4app.com/functions';

abstract class Endpoint {
  static const String signin = '$baseUrl/login';
  static const String signup = '$baseUrl/signup';
  static const String validateToken = '$baseUrl/validate-token';
  static const String resetPassword = '$baseUrl/reset-password';
  static const String getAllCategories = '$baseUrl/get-category-list';
  static const String getAllProducts = '$baseUrl/get-product-list';
  static const String getCarItens = "$baseUrl/get-cart-items";
  static const String addItemToCart = "$baseUrl/add-item-to-cart";
}
