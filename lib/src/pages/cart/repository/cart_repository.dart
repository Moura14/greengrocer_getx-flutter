import 'package:greengrocer/src/constants/endpoint.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/order_model.dart';
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

  Future<CartResult<OrderModel>> checkoutCart({
    required String token,
    required double total,
  }) async {
    final result = await _httpMenager
        .restRequest(url: Endpoint.checkout, method: HttpMethods.post, body: {
      'total': total
    }, headers: {
      'X-Parse-Session-Token': token,
    });
    if (result['result'] != null) {
      final order = OrderModel.fromJson(result['result']);
      return CartResult<OrderModel>.success(order);
    } else {
      return CartResult.error('Não foi possìvel realizar o pedido');
    }
  }

  Future<bool> changeItemQuantity(
      {required String token,
      required String cartItemId,
      required int quantity}) async {
    final result = await _httpMenager.restRequest(
        url: Endpoint.changeItemQuantity,
        method: HttpMethods.post,
        body: {'cartItemId': cartItemId, 'quantity': quantity},
        headers: {'X-Parse-Session-Token': token});

    return result.isEmpty;
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
