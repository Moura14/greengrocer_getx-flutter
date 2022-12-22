import 'package:greengrocer/src/constants/endpoint.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/pages/cart/cart_result/cart_result.dart';
import 'package:greengrocer/src/services/http_menager.dart';

class CartRepository {
  final _httpMenager = HttpMenager();

  Future<CartResult<List<CartItemModel>>> getCartitems(
      {required String token, required String userId}) async {
    final result = await _httpMenager.restRequest(
        url: Endpoint.getCarItens,
        method: HttpMethods.post,
        headers: {'X-Parse-Session-Token': token},
        body: {'user': userId});

    if (result['result'] != null) {
      List<CartItemModel> data =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromJson)
              .toList();
      return CartResult<List<CartItemModel>>.success(data);
    } else {
      return CartResult.error(
          'Ocorreu um erro ao recuperar os itens do carrinho');
    }
  }

  Future<CartResult<String>> addItemToCart(
      {required String userId,
      required String token,
      required String productId,
      required int quantity}) async {
    final result = await _httpMenager.restRequest(
        url: Endpoint.addItemToCart,
        method: HttpMethods.post,
        body: {'user': userId, 'quantity': quantity, 'productId': productId},
        headers: {'X-Parse-Session-Token': token});

    if (result['result'] != null) {
      return CartResult<String>.success(result['result']['id']);
    } else {
      return CartResult.error(
          'Não foi possível adicionar novos itens no carrinho');
    }
  }
}
