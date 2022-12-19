import 'package:greengrocer/src/constants/endpoint.dart';
import 'package:greengrocer/src/services/http_menager.dart';

class CartRepository {
  final _httpMenager = HttpMenager();

  Future getCartitems({required String token, required String userId}) async {
    final result = await _httpMenager.restRequest(
        url: Endpoint.getCarItens,
        method: HttpMethods.post,
        headers: {'X-Parse-Session-Token': token},
        body: {'user': userId});

    if (result['result'] != null) {
      print(result['result']);
    } else {
      print('Ocorreu um erro ao recuperar os itens do carrinho');
    }
  }
}
