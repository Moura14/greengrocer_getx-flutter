import 'package:greengrocer/src/constants/endpoint.dart';
import 'package:greengrocer/src/models/category_model.dart';
import 'package:greengrocer/src/pages/home/home/home_result.dart';
import 'package:greengrocer/src/services/http_menager.dart';

class HomeRepository {
  final HttpMenager _httpMenager = HttpMenager();

  Future<HomeResult<CategoryModel>> getAllCategories() async {
    final result = await _httpMenager.restRequest(
      url: Endpoint.getAllCategories,
      method: HttpMethods.post,
    );
    if (result['result'] != null) {
      List<CategoryModel> data =
          (List<Map<String, dynamic>>.from(result['result']))
              .map(CategoryModel.fromJson)
              .toList();

      return HomeResult<CategoryModel>.success(data);
    } else {
      return HomeResult.error(
          'Ocorreu um erro inesperado ao recuperar as categorias');
    }
  }
}
