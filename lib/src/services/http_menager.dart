import 'package:dio/dio.dart';

abstract class HttpMethods {
  static const String post = 'POST';
  static const String get = 'GET';
  static const String put = 'PUT';
  static const String delete = 'DELETE';
}

class HttpMenager {
  Future<Map> restRequest(
      {required String url,
      required String method,
      Map? headers,
      Map? body}) async {
    //headers da requisição
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({
        'content-type': 'aplication/json',
        'accept': 'aplication/json',
        'X-Parse-Aplication-Id': 'g1Oui3jqxny4S1ykpQWHwEKGOeOdRYCPvPF4iykc',
        'X-Parse-REST-API-Key': 'rFBKU8tk0m5ZIKES2CGieOaoYz6TgKxVMv8jRIsN'
      });

    Dio dio = Dio();
    try {
      Response response = await dio.request(url,
          options: Options(method: method, headers: defaultHeaders),
          data: body);

      //Retorno do resultado do server
      return response.data;
      //Retorno do erro do dio request
    } on DioError catch (error) {
      return error.response?.data ?? {};
    } catch (error) {
      //Retorno de map vazio para erros generalizados
      return {};
    }
  }
}
