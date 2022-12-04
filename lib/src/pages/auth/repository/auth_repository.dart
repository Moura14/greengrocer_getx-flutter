import 'package:greengrocer/src/constants/endpoint.dart';
import 'package:greengrocer/src/models/user_model.dart';
import 'package:greengrocer/src/pages/auth/repository/auth_error.dart'
    as authErrors;
import 'package:greengrocer/src/pages/auth/result/auth_result.dart';
import 'package:greengrocer/src/services/http_menager.dart';

class AuthRepository {
  final HttpMenager _httpMenager = HttpMenager();

  AuthResult heandleUserForError(Map<dynamic, dynamic> result) {
    if (result['result'] != null) {
      final user = UserModel.fromJson(result['result']);
      return AuthResult.success(user);
    } else {
      return AuthResult.error(authErrors.authErrorsString(result['error']));
    }
  }

  Future<AuthResult> validateToken(String token) async {
    final result = await _httpMenager.restRequest(
        url: Endpoint.validateToken,
        method: HttpMethods.post,
        headers: {
          'X-Parse-Session-Token': token,
        });
    return heandleUserForError(result);
  }

  Future<AuthResult> signIn(
      {required String email, required String password}) async {
    final result = await _httpMenager.restRequest(
      url: Endpoint.signin,
      method: HttpMethods.post,
      body: {'email': email, 'password': password},
    );
    return heandleUserForError(result);
  }

  Future<AuthResult> signUp(UserModel user) async {
    final result = await _httpMenager.restRequest(
      url: Endpoint.signup,
      method: HttpMethods.post,
      body: user.toJson(),
    );
    return heandleUserForError(result);
  }
}
