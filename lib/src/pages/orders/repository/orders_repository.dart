import 'package:greengrocer/src/constants/endpoint.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/pages/orders/orders_result/orders_result.dart';
import 'package:greengrocer/src/services/http_menager.dart';

class OrderRepository {
  final _httpMenager = HttpMenager();

  Future<OrderResult<List<CartItemModel>>> getOrderItems(
      {required String orderId, required String token}) async {
    final result = await _httpMenager.restRequest(
        url: Endpoint.getOrderItems,
        method: HttpMethods.post,
        body: {'orderId': orderId},
        headers: {'X-Parse-Session-Token': token});

    if (result['result'] != null) {
      List<CartItemModel> items =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromJson)
              .toList();

      return OrderResult<List<CartItemModel>>.success(items);
    } else {
      return OrderResult.error(
          'Não foi possível recuperar os produtos dos pedidos');
    }
  }

  Future<OrderResult<List<OrderModel>>> getAllOrders({
    required String userId,
    required String token,
  }) async {
    final result = await _httpMenager.restRequest(
        url: Endpoint.getAllOrders,
        method: HttpMethods.post,
        body: {
          'user': userId,
        },
        headers: {
          'X-Parse-Session-Token': token
        });

    if (result['result'] != null) {
      List<OrderModel> orders =
          List<Map<String, dynamic>>.from(result['result'])
              .map(OrderModel.fromJson)
              .toList();
      return OrderResult<List<OrderModel>>.success(orders);
    } else {
      return OrderResult.error('Não foi possível recuperar os pedidos');
    }
  }
}
